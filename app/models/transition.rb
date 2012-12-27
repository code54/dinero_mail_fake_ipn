class Transition < ActiveRecord::Base
  belongs_to :operation

  validates :notification_delay, numericality: { allow_nil: true, only_integer: true, greater_than_or_equal_to: -1 }
  validates :schedule_delay, numericality: { only_integer: true, greater_than_or_equal_to: 0 }

  before_create :set_delays

  attr_accessor :notification_delay, :schedule_delay

private

  def set_delays
    set_scheduled_at
    set_notify_at
  end

  def set_scheduled_at
    self.scheduled_at = created_at + schedule_delay.minutes
  end

  def set_notify_at
    return unless notification_delay.respond_to?(:minutes) && notification_delay >= 0
    self.notify_at = scheduled_at + notification_delay.minutes
  end
end
