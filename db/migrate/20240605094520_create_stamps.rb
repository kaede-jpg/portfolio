class CreateStamps < ActiveRecord::Migration[7.1]
  def change
    create_table :stamps do |t|

      t.timestamps
    end
  end
end
