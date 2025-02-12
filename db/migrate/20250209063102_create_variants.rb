class CreateVariants < ActiveRecord::Migration[7.1]
  def change
    create_table :variants do |t|
      t.references :product, null: false, foreign_key: true

      # Если нужно установить на определенный цвет/размер большую/меньшую цену, то
      # указанная здесь цена будет переопределять base_price из таблицы Products
      t.decimal :price, precision: 10, scale: 2, null: true

      # Статус наличия товара и его количество на складе
      # Доступные статусы: in_stock, out_of_stock, pre_order
      t.text :stock_status, default: "out_of_stock", null: false
      t.integer :stock_quantity, null: false, default: 0

      # Изменяемые параметры товара
      t.text :color, null: false
      t.text :size, null: false
      t.float :weight

      t.timestamps
    end

    add_index :variants, :product_id, unique: true

    # Ограничение на минимальную цену
    execute <<-SQL
      ALTER TABLE variants ADD CONSTRAINT price_non_negative CHECK (price > 0);
    SQL

    # Ограничение на возможные статусы наличия
    execute <<-SQL
      ALTER TABLE variants ADD CONSTRAINT stock_status_check CHECK (stock_status IN ('in_stock', 'out_of_stock', 'pre_order'));
    SQL

    # Ограничение на возможные размеры одежды
    execute <<-SQL
      ALTER TABLE variants ADD CONSTRAINT size_check CHECK (size IN ("S", "M", "L", "XL", "XXL"))
    SQL

  end
end
