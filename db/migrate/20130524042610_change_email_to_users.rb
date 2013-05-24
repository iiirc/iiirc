class ChangeEmailToUsers < ActiveRecord::Migration
  def up
    change_column :users, :email, :string, :null => true
  end

  def down
    User.where(email: nil).each do |user|
      user.email = ''
      user.save!
    end
    change_column :users, :email, :string, :null => false
  end
end
