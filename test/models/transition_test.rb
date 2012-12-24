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

  test "notification delay validation" do
    transition = Transition.new
    transition.valid?
    assert transition.errors[:notification_delay].empty?

    transition.notification_delay = 'abc'
    assert_equal 'abc', transition.notification_delay
    transition.valid?
    assert transition.errors[:notification_delay].any?

    transition.notification_delay = 1.1
    transition.valid?
    assert transition.errors[:notification_delay].any?

    transition.notification_delay = -1
    transition.valid?
    assert transition.errors[:notification_delay].any?

    transition.notification_delay = 0
    transition.valid?
    assert transition.errors[:notification_delay].empty?

    transition.notification_delay = 10
    transition.valid?
    assert transition.errors[:notification_delay].empty?
  end

  test "sets the scheduled_at attribute when it is created" do
    transition = Transition.new(schedule_delay: 1)
    transition.save!
    assert_equal transition.created_at + 1.minute, transition.scheduled_at
  end

  test "sets the notify_at attribute when it is created and notify_delay is present" do
    transition = Transition.new(schedule_delay: 1, notification_delay: 2)
    transition.save!
    assert_equal transition.created_at + 2.minute, transition.notify_at
  end
end
