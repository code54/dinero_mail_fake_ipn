class Transition < ActiveRecord::Base
  belongs_to :operation

  validates :notification_delay, numericality: { allow_nil: true, only_integer: true, greater_than_or_equal_to: -1 }, if: :new_record?
  validates :schedule_delay, numericality: { only_integer: true, greater_than_or_equal_to: 0 }, if: :new_record?

  before_create :set_delays

  attr_accessor :notification_delay, :schedule_delay

  def ready?(comparison_time = current_time_from_proper_timezone)
    scheduled_at <= comparison_time
  end

  def performed?
    performed_at.present?
  end

  def perform
    raise TransitionError if performed? or !ready?

    transaction do
      operation.update_attributes!(status: status)
      update_attributes!(performed_at: current_time_from_proper_timezone)
    end
  end

private

  def set_delays
    set_scheduled_at
    set_notify_at
  end

  def set_scheduled_at
    self.scheduled_at = created_at + schedule_delay.to_i.minutes
  end

  def set_notify_at
    return unless notification_delay.present? && notification_delay.to_i >= 0
    self.notify_at = scheduled_at + notification_delay.to_i.minutes
  end
end

class TransitionError < StandardError; end
