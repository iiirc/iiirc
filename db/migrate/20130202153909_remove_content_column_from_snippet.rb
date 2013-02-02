class RemoveContentColumnFromSnippet < ActiveRecord::Migration
  def change
    remove_column :snippets, :content
  end
end
