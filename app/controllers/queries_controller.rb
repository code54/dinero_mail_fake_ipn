class QueriesController < ApplicationController
  skip_before_filter :verify_authenticity_token

  def create
    query = Query.new(question_document: params[:DATA])
    query.answer
    query.save!

    send_data(query.answer_document, type: 'application/xml')
  end
end
