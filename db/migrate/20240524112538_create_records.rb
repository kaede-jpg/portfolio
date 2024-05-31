class CreateRecords < ActiveRecord::Migration[7.1]
  def change
    create_table :records do |t|
      t.references :user, foreign_key: true, null: false

      t.timestamps
    end
  end
end
