class SimplifyTransitionsNotification < ActiveRecord::Migration
  def up
    change_table :transitions do |t|
      t.remove :notify_at
      t.boolean :needs_notification
    end
  end

  def down
    change_table :transitions do |t|
      t.remove :needs_notification
      t.datetime :notify_at
      t.index :notify_at
    end
  end
end
