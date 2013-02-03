class AddHashIdToSnippet < ActiveRecord::Migration
  def change
    add_column :snippets, :hash_id, :string, after: :user_id
  end
end
