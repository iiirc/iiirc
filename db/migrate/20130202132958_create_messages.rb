class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.text :raw_content
      t.text :content
      t.string :nick

      t.timestamps
    end
  end
end
