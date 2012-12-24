class CreateOperations < ActiveRecord::Migration
  def change
    create_table :operations do |t|
      t.references :integration_request, index: true
      t.string :client_id, limit: 20
      t.integer :status
      t.string :buyer_full_name
      t.string :buyer_document_type
      t.string :buyer_document_number
      t.string :buyer_email
      t.string :buyer_address
      t.text :buyer_comment
      t.string :buyer_phone
      t.integer :payment_method_type
      t.string :payment_method
      t.integer :number_of_payments

      t.timestamps

      t.index :client_id, unique: true
    end
  end
end
