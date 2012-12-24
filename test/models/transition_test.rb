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
end
