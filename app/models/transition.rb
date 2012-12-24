class Transition < ActiveRecord::Base
  belongs_to :operation

  validates :notification_delay, numericality: { allow_nil: true, only_integer: true, greater_than_or_equal_to: 0 }
  validates :schedule_delay, numericality: { only_integer: true, greater_than_or_equal_to: 0 }

  before_create :set_scheduled_at
  before_create :set_notify_at

  attr_accessor :notification_delay, :schedule_delay

private

  def set_scheduled_at
    self.scheduled_at = created_at + schedule_delay.minutes
  end

  def set_notify_at
    return unless notification_delay.respond_to?(:minutes)
    self.notify_at = created_at + notification_delay.minutes
  end
end
