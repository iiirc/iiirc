class AddUserIdToUsers < ActiveRecord::Migration
  def change
    add_column :users, :user_id, :integer, null: false, after: :id
    add_index :users, :user_id
  end
end
