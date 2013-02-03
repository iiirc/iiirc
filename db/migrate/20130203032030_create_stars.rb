class CreateStars < ActiveRecord::Migration
  def change
    create_table :stars do |t|
      t.references :user
      t.references :message
      t.integer :count, null: false, default: 0

      t.timestamps
    end

    add_index :stars, :user_id
    add_index :stars, :message_id
  end
end
