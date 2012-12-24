class CreateIntegrationRequests < ActiveRecord::Migration
  def change
    create_table :integration_requests do |t|
      t.text :raw

      t.timestamps
    end
  end
end
