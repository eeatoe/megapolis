class AddBrandToProducts < ActiveRecord::Migration[7.1]
  def change
    add_reference :products, :brand, null: true, foreign_key: true
  end
end
