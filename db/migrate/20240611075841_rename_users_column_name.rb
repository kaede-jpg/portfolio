class RenameUsersColumnName < ActiveRecord::Migration[7.1]
  def change
    rename_column :users, :invitation_digest, :relationship_digest
    rename_column :users, :invitation_made_at, :relationship_code_made_at
    rename_column :users, :invitation_my_role, :role
  end
end
