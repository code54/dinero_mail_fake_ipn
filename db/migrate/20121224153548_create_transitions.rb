class CreateTransitions < ActiveRecord::Migration
  def change
    create_table :transitions do |t|
      t.references :operation, index: true
      t.integer :status
      t.datetime :scheduled_at
      t.datetime :performed_at
      t.datetime :notify_at

      t.timestamps

      t.index :scheduled_at
      t.index :notify_at
    end
  end
end
