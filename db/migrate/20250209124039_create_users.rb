class CreateUsers < ActiveRecord::Migration[7.1]
  def change
    create_table :users do |t|
      t.string :email, null: false
      t.string :password_digest, null: false
      t.string :name, null: false
      t.integer :role, null: false, default: 0

      t.index :email, unique: true

      t.timestamps
    end

    # Ограничение на возможные роли пользователя
    execute <<-SQL
      ALTER TABLE users ADD CONSTRAINT role_check CHECK (role IN (0, 1));
    SQL

  end
end
