class SorceryUserActivation < ActiveRecord::Migration[7.1]
  def change
    change_table :users, bulk: true do |t|
      t.string :activation_state, default: nil
      t.string :activation_token, default: nil
      t.datetime :activation_token_expires_at, default: nil
    end
    add_index :users, :activation_token, unique: true
  end
end
