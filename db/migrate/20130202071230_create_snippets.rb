class CreateSnippets < ActiveRecord::Migration
  def change
    create_table :snippets do |t|
      t.string :title
      t.text :content
      t.boolean :published

      t.timestamps
    end
  end
end
