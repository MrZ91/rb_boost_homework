class CreateLessons < ActiveRecord::Migration
  def change
    create_table :lessons do |t|
      t.string :title, null: false
      t.string :image
      t.text :description
      t.text :lecture_notes, null: false
      t.text :homework_text
      t.integer :position, limit: 2, null: false, default: 1
      t.integer :course_id, null: false

      t.timestamps
    end

    add_index :lessons, [:course_id, :position], unique: true
  end
end
