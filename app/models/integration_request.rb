class IntegrationRequest < ActiveRecord::Base
  has_one :operation

  serialize :raw

  def build_operation(attributes = {})
    super(attributes.merge(unchangeable_operation_attributes))
  end

  def build_prefilled_operation
    build_operation(prefilled_operation_attributes)
  end

private

  def unchangeable_operation_attributes
    {
      client_id: raw['transaction_id'],
      items: items_attributes.map { |item_attributes| Item.new(item_attributes) }
    }
  end

  def prefilled_operation_attributes
    {
      buyer_phone: raw['buyer_phone'],
      buyer_email: raw['buyer_email']
    }
  end

  def items_attributes
    result = []
    raw.each do |key, value|
      if (match = key.match(/item_(name|ammount|quantity)_(\d+)/))
        index = match.captures[1].to_i - 1
        name = match.captures[0]
        if name == 'ammount'
          name = 'amount'
          value = value.to_i / 100.0
        end
        (result[index] ||= {})[name] = value
      end
    end
    result
  end
end
