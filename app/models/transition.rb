class Transition < ActiveRecord::Base
  belongs_to :operation

  validates :notification_delay, numericality: { allow_nil: true, only_integer: true, greater_than_or_equal_to: 0 }
  validates :schedule_delay, numericality: { only_integer: true, greater_than_or_equal_to: 0 }

  attr_accessor :notification_delay, :schedule_delay
end
