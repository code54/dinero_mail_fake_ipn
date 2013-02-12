require 'test_helper'

class OperationTest < ActiveSupport::TestCase
  test "net amount calculation" do
    item_1 = MiniTest::Mock.new
    item_1.expect :subtotal, BigDecimal('75.25'), []

    item_2 = MiniTest::Mock.new
    item_2.expect :subtotal, BigDecimal('24.75'), []

    operation = Operation.new

    operation.stub :items, [item_1, item_2] do
      assert_equal BigDecimal('100'), operation.net_amount
    end
  end

  test "amount calculation" do
    operation = Operation.new

    operation.stub :net_amount, BigDecimal('100') do
      assert_equal BigDecimal('106'), operation.amount
    end
  end
end
