class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.references :snippet
      t.text :raw_content
      t.text :content
      t.string :nick

      t.timestamps
    end

    add_index :messages, :snippet_id
    add_index :messages, :nick
  end
end
