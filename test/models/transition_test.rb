require 'test_helper'

class TransitionTest < ActiveSupport::TestCase
  test "schedule delay validation" do
    transition = Transition.new
    transition.valid?
    assert transition.errors[:schedule_delay].any?

    transition.schedule_delay = 'abc'
    assert_equal 'abc', transition.schedule_delay
    transition.valid?
    assert transition.errors[:schedule_delay].any?

    transition.schedule_delay = 1.1
    transition.valid?
    assert transition.errors[:schedule_delay].any?

    transition.schedule_delay = -1
    transition.valid?
    assert transition.errors[:schedule_delay].any?

    transition.schedule_delay = 0
    transition.valid?
    assert transition.errors[:schedule_delay].empty?

    transition.schedule_delay = 10
    transition.valid?
    assert transition.errors[:schedule_delay].empty?
  end

  test "sets the scheduled_at attribute when it is created" do
    transition = Transition.new(schedule_delay: 1)
    transition.save!
    assert_equal transition.created_at + 1.minute, transition.scheduled_at
  end

  test "on or out of schedule" do
    transition = Transition.new(scheduled_at: Time.now)

    assert transition.on_schedule?(transition.scheduled_at)
    assert transition.on_schedule?(transition.scheduled_at + 1.second)
    refute transition.on_schedule?(transition.scheduled_at - 1.second)
  end

  test "was peformed when there's a perfomed_at datetime" do
    transition = Transition.new(scheduled_at: Time.now)

    assert_nil transition.performed_at
    refute transition.performed?

    transition.performed_at = transition.scheduled_at + 1.second
    assert transition.performed?
  end

  test "ready or not" do
    transition = Transition.new(scheduled_at: Time.now)

    assert transition.ready?(transition.scheduled_at)
    refute transition.ready?(transition.scheduled_at - 1.second)

    transition.performed_at = transition.scheduled_at
    refute transition.ready?(transition.scheduled_at)
  end

  test "performing a transition which is ready to be made" do
    transition = transitions(:jacket_ready_to_completed)
    operation = transition.operation

    refute transition.performed?
    assert_not_equal operation.status, transition.status

    transition.perform

    assert transition.performed?
    assert_equal transition.status, operation.status
    refute transition.changed?
    refute operation.changed?
  end

  test "performing a transaction which isn't ready to be made" do
    transition = transitions(:jacket_not_ready)
    operation = transition.operation

    assert_no_difference ->{ operation.updated_at } do
      assert_no_difference ->{ transition.updated_at } do
        assert_raise TransitionError do
          transition.perform
        end
      end
    end
  end

  test "performing a transaction which has already be performed" do
    transition = transitions(:jacket_already_performed)
    operation = transition.operation

    assert_no_difference ->{ operation.updated_at } do
      assert_no_difference ->{ transition.updated_at } do
        assert_raise TransitionError do
          transition.perform
        end
      end
    end
  end

end
