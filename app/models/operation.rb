class Operation < ActiveRecord::Base
  belongs_to :integration_request
  has_many :items
  has_many :transitions

  accepts_nested_attributes_for :transitions
end
