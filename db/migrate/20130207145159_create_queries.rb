class CreateQueries < ActiveRecord::Migration
  def change
    create_table :queries do |t|
      t.text :question_document
      t.text :answer_document

      t.timestamps
    end
  end
end
