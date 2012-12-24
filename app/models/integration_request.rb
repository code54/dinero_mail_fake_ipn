class IntegrationRequest < ActiveRecord::Base
  has_one :operation

  serialize :raw
end
