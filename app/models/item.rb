class Item < ActiveRecord::Base
  belongs_to :operation

  def subtotal
    amount * quantity
  end
end
