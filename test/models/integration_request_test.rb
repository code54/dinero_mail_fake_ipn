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
  end
end
