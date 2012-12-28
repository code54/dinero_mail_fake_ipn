require 'test_helper'

class OperationsControllerTest < ActionController::TestCase
  test "new operation" do
    integration_request = integration_requests(:hair_growing_cream)

    get :new, integration_request_id: integration_request.id

    assert_response :success

    operation = assigns(:operation)

    assert_not_nil operation
    assert_equal integration_request, operation.integration_request
    assert_template :new
  end

  test "successful operation creation" do
    integration_request = integration_requests(:hair_growing_cream)
    attributes = { 'buyer_email' => 'buyer@exmaple.com' }

    assert_difference ->{ Operation.count } do
      post :create, integration_request_id: integration_request.id, operation: attributes
    end

    operation = assigns(:operation)

    assert_not_nil operation
    assert_equal integration_request, operation.integration_request
    assert_equal attributes['buyer_email'], operation.buyer_email

    assert_response :redirect
    assert_redirected_to integration_request.ok_url
  end
end
