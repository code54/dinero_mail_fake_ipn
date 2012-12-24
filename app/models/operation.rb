class Operation < ActiveRecord::Base
  belongs_to :integration_request
  has_many :items
end
