class CreateRelationships < ActiveRecord::Migration[7.1]
  def change
    create_table :relationships do |t|
      t.integer :monitor_id, index: true, null: false, index: { unique: true }
      t.integer :monitored_id, index: true, null: false

      t.timestamps
    end
    add_foreign_key :relationships, :users, column: :monitor_id
    add_foreign_key :relationships, :users, column: :monitored_id
  end
end
