class IntegrationRequestsController < ApplicationController
  skip_before_filter :verify_authenticity_token

  def create
    @integration_request = IntegrationRequest.create!(integration_request_attributes)
    # TODO: redirect to the checkout form.
    render text: 'success'
  end

private

  def integration_request_attributes
    { raw: params.except(*request.path_parameters.keys) }
  end
end
