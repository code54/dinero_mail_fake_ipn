require 'test_helper'

class AnswererTest < ActiveSupport::TestCase
  def answer_document(name)
    path = Rails.root.join('test', 'fixtures', 'files', 'answer_documents', "#{name}.xml")
    File.read(path)
  end

  test "answer document generation" do
    query = queries(:unanswered_hair_growing_cream_and_socks)
    answerer = Answerer.new(query)
    assert_equal answer_document(:hair_growing_cream_and_socks), answerer.answer_document
  end
end
