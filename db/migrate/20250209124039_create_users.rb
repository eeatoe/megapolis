class CreateUsers < ActiveRecord::Migration[7.1]
  def change
    create_table :users do |t|
      t.string :email, unique: true, null: false
      t.string :password_digest, null: false
      t.string :name, null: false
      t.string :role, default: "customer", null: false

      t.timestamps
    end

    add_index :users, :email, unique: true

    # Ограничение на возможные роли пользователя
    execute <<-SQL
      ALERT TABLE users ADD CONSTRAINT role_check CHECK (role IN ('customer', 'admin'));
    SQL

  end
end
