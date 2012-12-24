require 'test_helper'

class IntegrationRequestTest < ActiveSupport::TestCase
  test "serializes it's raw attribute" do
    raw = { param_1: 'value 1', param_2: 'value 2' }
    integration_request = IntegrationRequest.create!(raw: raw)
    assert_equal raw, integration_request.reload.raw
  end
end
