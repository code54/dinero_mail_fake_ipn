require 'test_helper'

class ItemTest < ActiveSupport::TestCase
  test "subtotal calculation" do
    item = Item.new(amount: 33.33, quantity: 3)
    assert_equal BigDecimal.new('99.99'), item.subtotal
  end
end
