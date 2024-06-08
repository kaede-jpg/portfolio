class CreateStampedRecords < ActiveRecord::Migration[7.1]
  def change
    create_table :stamped_records do |t|
      t.references :record, null: false, foreign_key: true
      t.references :stamp, null: false, foreign_key: true

      t.timestamps
    end
  end
end
