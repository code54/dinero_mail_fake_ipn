require 'test_helper'

class IntegrationRequestTest < ActiveSupport::TestCase
  test "serializes it's raw attribute" do
    raw = { param_1: 'value 1', param_2: 'value 2' }
    integration_request = IntegrationRequest.create!(raw: raw)
    assert_equal raw, integration_request.reload.raw
  end

  test "builds a prefilled operation from it's raw attribute" do
    integration_request = IntegrationRequest.new raw: {
      'buyer_phone' => '0303456',
      'buyer_email' => 'jerry@seinfeld.com'
    }

    operation = integration_request.build_prefilled_operation
    assert_equal '0303456', operation.buyer_phone
    assert_equal 'jerry@seinfeld.com', operation.buyer_email
  end
end
