class CreateCategories < ActiveRecord::Migration[7.1]
  def change
    create_table :categories do |t|
      t.string :name, null: false
      t.string :slug, null: false
      
      t.references :parent, foreign_key: { to_table: :categories }, null: true

      t.index :name, unique: true
      t.index :slug, unique: true

      t.timestamps
    end
  end
end
