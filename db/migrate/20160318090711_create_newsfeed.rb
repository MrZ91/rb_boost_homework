class CreateNewsfeed < ActiveRecord::Migration
  def change
    create_table :newsfeeds do |t|
      t.integer :recipient_id, null: false
      t.integer :owner_id, null: false
      t.integer :trackable_id, null: false
      t.string  :trackable_type
      t.integer  :kind

      t.timestamps null: false
    end

    add_index :newsfeeds, :recipient_id
    add_index :newsfeeds, :owner_id
    add_index :newsfeeds, [:trackable_id, :trackable_type]
  end
end
