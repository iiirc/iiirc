class CreateOrganizations < ActiveRecord::Migration
  def change
    create_table :organizations do |t|
      t.string  :login,        :null => false
      t.integer :original_id, :null => false

      t.timestamps
    end
  end
end
