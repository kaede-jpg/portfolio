class CreateStamps < ActiveRecord::Migration[7.1]
  def change
    create_table :stamps, &:timestamps
  end
end
