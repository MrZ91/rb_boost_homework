class CreateHomeworkAdvancements < ActiveRecord::Migration
  def change
    create_table :advancements do |t|
      t.integer :user_id
      t.integer :lesson_id
      t.text :version, null: false

      t.timestamps null: false
    end

    add_index :advancements, [:user_id, :lesson_id], unique: true
  end
end
