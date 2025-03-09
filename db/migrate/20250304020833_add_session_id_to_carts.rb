class AddSessionIdToCarts < ActiveRecord::Migration[7.1]
  def change
    add_column :carts, :session_id, :string, null: true
    add_index :carts, :session_id
  end
end
