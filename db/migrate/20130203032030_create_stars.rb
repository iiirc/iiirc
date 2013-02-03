class CreateStars < ActiveRecord::Migration
  def change
    create_table :stars do |t|
      t.reference :user
      t.reference :message
      t.integer :count

      t.timestamps
    end
  end
end
