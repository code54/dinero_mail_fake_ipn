require 'test_helper'

class QueryTransactionIdentificationTest < ActiveSupport::TestCase
  def question_document(name)
    path = Rails.root.join('test', 'fixtures', 'files', 'question_documents', "#{name}.xml")
    File.read(path)
  end

  test "document with several ids" do
    query = Query.new(question_document: question_document(:several_ids))
    assert_equal %w[1 2 3 6], query.transaction_ids
  end

  test "document with one id" do
    query = Query.new(question_document: question_document(:one_id))
    assert_equal %w[7], query.transaction_ids
  end

  test "downcased document" do
    query = Query.new(question_document: question_document(:downcased))
    assert_equal %w[1 2], query.transaction_ids
  end

  test "document missing 'id' tag" do
    query = Query.new(question_document: question_document(:missing_id))
    assert_equal [], query.transaction_ids
  end

  test "document missing 'operaciones' tag" do
    query = Query.new(question_document: question_document(:missing_operaciones))
    assert_equal [], query.transaction_ids
  end

  test "document missing 'consulta' tag" do
    query = Query.new(question_document: question_document(:missing_consulta))
    assert_equal [], query.transaction_ids
  end

  test "document missing 'detalle' tag" do
    query = Query.new(question_document: question_document(:missing_detalle))
    assert_equal [], query.transaction_ids
  end

  test "document missing 'reporte' tag" do
    query = Query.new(question_document: question_document(:missing_reporte))
    assert_equal [], query.transaction_ids
  end

  test "random document" do
    query = Query.new(question_document: question_document(:random))
    assert_equal [], query.transaction_ids
  end

  test "no xml document" do
    query = Query.new(question_document: question_document(:no_xml))
    assert_equal [], query.transaction_ids
  end
end

class QueryAnsweringTest < ActiveSupport::TestCase
  def setup
    @query = Query.new
    @answerer = MiniTest::Mock.new
  end

  test "without a question document" do
    assert_raise Query::CantBeAnsweredError do
      @query.answer(@answerer)
    end
  end

  test "with a question document" do
    @query.question_document = 'question document'
    @answerer.expect :answer_document, 'answer document', [@query]
    @query.answer(@answerer)
    @answerer.verify
    assert_equal 'answer document', @query.answer_document
  end
end
