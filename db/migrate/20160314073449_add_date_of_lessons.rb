class AddDateOfLessons < ActiveRecord::Migration
  def change
    add_column :lessons, :date_of, :datetime, null: false
    add_index :lessons, [:course_id, :date_of], unique: true
  end
end

