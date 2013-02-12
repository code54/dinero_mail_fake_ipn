class IntegrationRequestsController < ApplicationController
  skip_before_filter :verify_authenticity_token

  def create
    @integration_request = IntegrationRequest.create!(integration_request_attributes)
    redirect_to new_integration_request_operation_url(@integration_request)
  end

private

  def integration_request_attributes
    { raw: params.except(*request.path_parameters.keys) }
  end
end
