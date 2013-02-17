class Transition < ActiveRecord::Base
  belongs_to :operation

  validates :schedule_delay, numericality: { only_integer: true, greater_than_or_equal_to: 0 }, if: :new_record?

  before_create :set_scheduled_at

  attr_accessor :schedule_delay

  def self.ready(comparison_time = Time.now)
    where(performed_at: nil).where(arel_table[:scheduled_at].lteq(comparison_time))
  end

  def ready?(comparison_time = current_time_from_proper_timezone)
    !performed? and on_schedule?(comparison_time)
  end

  def on_schedule?(comparison_time = current_time_from_proper_timezone)
    scheduled_at <= comparison_time
  end

  def performed?
    performed_at.present?
  end

  def perform
    raise TransitionError if performed? or !on_schedule?

    transaction do
      operation.update_attributes!(status: status)
      update_attributes!(performed_at: current_time_from_proper_timezone)
    end
  end

private

  def set_scheduled_at
    self.scheduled_at = created_at + schedule_delay.to_i.minutes
  end
end

class TransitionError < StandardError; end
