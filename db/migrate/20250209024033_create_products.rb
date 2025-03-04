class CreateProducts < ActiveRecord::Migration[7.1]
  def change
    create_table :products do |t|
      t.string :name, null: false
      t.text :description, null: false
      t.decimal :base_price, precision: 10, scale: 2, null: false
      t.float :average_rating, default: 0, null: false

      # Общие параметры товара
      t.text :main_material, null: false
      t.text :filling_material

      t.index :name

      t.timestamps
    end

    # Ограничение на минимальную цену
    execute <<-SQL
      ALTER TABLE products ADD CONSTRAINT base_price_non_negative CHECK (base_price > 0);
    SQL

  end
end
