class CreateBrands < ActiveRecord::Migration[7.1]
  def change
    create_table :brands do |t|
      t.string :name, null: false
      t.string :slug, null: false
      
      t.index :name, unique: true
      t.index :slug, unique: true

      t.timestamps
    end
  end
end
