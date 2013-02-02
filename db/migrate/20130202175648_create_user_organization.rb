class CreateUserOrganization < ActiveRecord::Migration
  def change
    create_table :user_organizations do |t|
      t.integer  :user_id,                  null: false
      t.integer  :organization_id,          null: false
      t.datetime :deleted_at, default: nil

      t.timestamps
    end
    add_index :user_organizations, [:user_id, :organization_id], name: "index_user_id_x_organization_id", unique: true
  end
end
