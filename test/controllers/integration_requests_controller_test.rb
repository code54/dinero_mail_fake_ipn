require 'test_helper'

class IntegrationRequestsControllerTest < ActionController::TestCase
  test "integration request creation" do
    params = { 'transaction_id' => '1' }

    assert_difference ->{ IntegrationRequest.count } do
      post :create, params
    end

    integration_request = assigns(:integration_request)
    assert integration_request
    assert_equal params, integration_request.raw

    assert_response :redirect
    assert_redirected_to new_integration_request_operation_url(integration_request)
  end
end
