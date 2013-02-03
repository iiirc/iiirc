class AddTimeColumnToMessages < ActiveRecord::Migration
  def change
    add_column :messages, :time, :string, after: :nick
  end
end
