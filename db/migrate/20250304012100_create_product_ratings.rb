class CreateProductRatings < ActiveRecord::Migration[7.1]
  def change
    create_table :product_ratings do |t|
      t.references :product, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true

      t.integer :value, null: false

      t.index [:product_id, :user_id], unique: true

      t.timestamps
    end
  end
end
