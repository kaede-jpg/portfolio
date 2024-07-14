class AddScoreToStamp < ActiveRecord::Migration[7.1]
  def change
    change_table :stamps, bulk: true do |t|
      t.integer :score
    end
  end
end
