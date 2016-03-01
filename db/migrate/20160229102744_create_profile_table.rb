class CreateProfileTable < ActiveRecord::Migration
  def change
    create_table :profiles do |t|
      t.string :first_name, null: false
      t.string :last_name, null: false
      t.integer :user_id, null: false

      t.timestamps null: false
    end
    add_index :profiles, :user_id, unique: true

    remove_column :users, :first_name, type: :string, null: false, default: 'User'
    remove_column :users, :last_name, type: :string, null: false, default: 'Name'
  end
end
