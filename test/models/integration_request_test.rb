require 'test_helper'

class IntegrationRequestTest < ActiveSupport::TestCase
  test "serializes it's raw attribute" do
    raw = { param_1: 'value 1', param_2: 'value 2' }
    integration_request = IntegrationRequest.create!(raw: raw)
    assert_equal raw, integration_request.reload.raw
  end

  test "builds a prefilled operation from it's raw attribute" do
    integration_request = integration_requests(:jacket)

    operation = integration_request.build_prefilled_operation
    assert_equal integration_request.raw['buyer_phone'], operation.buyer_phone
    assert_equal integration_request.raw['buyer_email'], operation.buyer_email
    assert_equal integration_request.raw['transaction_id'], operation.client_id

    assert_equal 1, operation.items.size
    item = operation.items.first

    assert_equal integration_request.raw['item_name_1'], item.name
    assert_equal integration_request.raw['item_quantity_1'].to_i, item.quantity
    assert_equal integration_request.raw['item_ammount_1'].to_i / 100.0, item.amount
  end

  test "builds an operation with user provided attributes" do
    integration_request = integration_requests(:jacket)

    operation = integration_request.build_operation(
      buyer_phone: '4444',
      client_id: '333'
    )
    assert_equal '4444', operation.buyer_phone
    assert_nil operation.buyer_email
    assert_equal integration_request.raw['transaction_id'], operation.client_id
    assert_not_equal '333', operation.client_id

    assert_equal 1, operation.items.size
    item = operation.items.first

    assert_equal integration_request.raw['item_name_1'], item.name
    assert_equal integration_request.raw['item_quantity_1'].to_i, item.quantity
    assert_equal integration_request.raw['item_ammount_1'].to_i / 100.0, item.amount
  end

  test "knows the ok url callback" do
    ok_url = 'http://seinfeldshop.dev/dinero_mail/ok?token=1234'
    integration_request = IntegrationRequest.new(raw: { 'ok_url' => ok_url })
    assert_equal ok_url, integration_request.ok_url
  end
end
