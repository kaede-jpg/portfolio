class AddMealAdviseColumnToRecord < ActiveRecord::Migration[7.1]
  def change
    change_table :records, bulk: true do |t|
      t.string :meal_advise
    end
  end
end
