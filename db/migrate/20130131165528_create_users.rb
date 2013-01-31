class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :provider, :null => false
      t.string :uid,      :null => false
      t.string :username, :null => false, :uniq => true
      t.string :email,    :null => false

      t.timestamps
    end
    add_index :users, [:provider, :uid]
  end
end
