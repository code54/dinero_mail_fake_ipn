class IntegrationRequest < ActiveRecord::Base
  has_one :operation

  serialize :raw

  def build_prefilled_operation
    build_operation(prefilled_operation_attributes)
  end

private

  def prefilled_operation_attributes
    {
      buyer_phone: raw['buyer_phone'],
      buyer_email: raw['buyer_email']
    }
  end
end
