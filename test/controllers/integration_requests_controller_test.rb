require 'test_helper'

class IntegrationRequestsControllerTest < ActionController::TestCase
  test "integration request creation" do
    params = { 'transaction_id' => '1' }

    assert_difference ->{ IntegrationRequest.count } do
      post :create, params
    end

    assert_response :success
    assert_equal 'success', response.body

    integration_request = assigns(:integration_request)
    assert integration_request
    assert_equal params, integration_request.raw
  end
end
