class DeviseCreateUsers < ActiveRecord::Migration
  def change
    create_table(:users) do |t|
      t.string :email, null: false
      t.string :encrypted_password, null: false
      t.string :first_name, null: false
      t.string :last_name, null: false
      t.datetime :remember_created_at

      t.timestamps null: false
    end

    add_index :users, :email, unique: true
  end
end
