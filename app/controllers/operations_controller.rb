class OperationsController < ApplicationController
  before_filter :find_integration_request

  def new
    @operation = @integration_request.build_prefilled_operation
  end

  def create
    @operation = @integration_request.build_operation(operation_params)

    if @operation.save
      redirect_to @integration_request.ok_url
    else
      render :new
    end
  end

private

  def find_integration_request
    @integration_request = IntegrationRequest.find(params[:integration_request_id])
  end

  def operation_params
    params.require(:operation).permit(:buyer_full_name, :buyer_document_type, :buyer_document_number, :buyer_email, :buyer_address, :buyer_comment, :buyer_phone, :payment_method_type, :payment_method, :number_of_payments)
  end
end
