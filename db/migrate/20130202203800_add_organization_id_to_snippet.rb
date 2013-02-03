class AddOrganizationIdToSnippet < ActiveRecord::Migration
  def change
    add_column :snippets, :organization_id, :integer, after: :user_id
    add_index :snippets, :organization_id
  end
end
