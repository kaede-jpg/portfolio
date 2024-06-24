class RemoveUserIdColumnAndRenameRelationshipDigestColumnOfUsers < ActiveRecord::Migration[7.1]
  def change
    rename_column :users, :relationship_digest, :relationship_code
    remove_column :users, :user_id, :string
  end
end
