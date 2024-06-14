class AddInvitationColumnsToUser < ActiveRecord::Migration[7.1]
  def change
    change_table :users, bulk: true do |t|
      t.string :invitation_digest
      t.datetime :invitation_sent_at
      t.integer :invitation_my_role
    end

    add_index :users, :invitation_digest, unique: true
  end
end
