class CreateSocialProfilesTable < ActiveRecord::Migration
  def change
    create_table :social_profiles do |t|
      t.string :provider
      t.string :uid
      t.integer :user_id
      t.boolean :signed_up_with_social, default: true

      t.timestamps null: false
    end

    add_index :social_profiles, :user_id
    add_index :social_profiles, [:user_id, :provider], unique: true

    change_column_default :users, :encrypted_password, ''
  end
end
