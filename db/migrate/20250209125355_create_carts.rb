class CreateCarts < ActiveRecord::Migration[7.1]
  def change
    create_table :carts do |t|
      t.references :user, null: true, foreign_key: true
      t.string :session_id, null: true
      t.datetime :expires_at

      t.index :session_id, unique: true
      t.index :expires_at

      t.timestamps
    end
  end
end
