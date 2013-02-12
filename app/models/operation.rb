class Operation < ActiveRecord::Base
  belongs_to :integration_request
  has_many :items
  has_many :transitions

  accepts_nested_attributes_for :transitions

  def self.query(ids)
    where(client_id: ids)
  end

  def net_amount
    items.map(&:subtotal).sum
  end

  def amount
    net_amount * BigDecimal('1.06')
  end
end
