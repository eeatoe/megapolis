class CreateProducts < ActiveRecord::Migration[7.1]
  def change
    create_table :products do |t|
      t.string :name, null: false
      t.text :description, null: false
      t.integer :base_price, null: false, check: "base_price > 0"

      # Общие параметры товара
      t.text :main_material, null: false
      t.text :filling_material

      # Теги и категории для фильтрации и поиска товаров
      t.references :category, null: false, foreign_key: true
      t.references :brand, foreign_key: true

      t.timestamps
    end

    add_index :products, :name, unique: true

    # Ограничение на минимальную цену
    execute <<-SQL
      ALTER TABLE products ADD CONSTRAINT base_price_non_negative CHECK (base_price > 0);
    SQL

  end
end
