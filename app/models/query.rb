class Query < ActiveRecord::Base
  class CantBeAnsweredError < StandardError; end

  def transaction_ids
    find_transaction_ids_in_question_hash
  end

  def answer(answerer)
    raise CantBeAnsweredError if question_document.blank?
    self.answer_document = answerer.answer_document(self)
  end

private

  def find_transaction_ids_in_question_hash
    # TODO: understand how Nori works, think if is worth failing louder when the
    # question document is invalid, replace Nori, I don't really know right now.
    # What I do know is that this is ugly.
    Array(question_hash['reporte']['detalle']['consulta']['operaciones']['id'])
  rescue NoMethodError
    []
  end

  def question_hash
    parser = Nori.new(convert_tags_to: ->(tag){ tag.downcase })
    parser.parse(question_document)
  end
end
