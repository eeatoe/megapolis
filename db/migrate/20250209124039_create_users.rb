class CreateUsers < ActiveRecord::Migration[7.1]
  def change
    create_table :users do |t|
      t.string :email, null: false
      t.string :password_digest, null: false
      t.string :name, null: false
      t.string :role, null: false, default: "customer"

      t.index :email, unique: true

      t.timestamps
    end

    # Ограничение на возможные роли пользователя
    execute <<-SQL
      ALTER TABLE users ADD CONSTRAINT role_check CHECK (role IN ('customer', 'admin'));
    SQL

  end
end
