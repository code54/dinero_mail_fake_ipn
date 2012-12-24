class CreateItems < ActiveRecord::Migration
  def change
    create_table :items do |t|
      t.references :operation, index: true
      t.string :code
      t.string :name
      t.integer :quantity
      t.decimal :amount, precision: 10, scale: 2
      t.integer :currency

      t.timestamps
    end
  end
end
