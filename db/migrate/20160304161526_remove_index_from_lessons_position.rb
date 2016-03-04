class RemoveIndexFromLessonsPosition < ActiveRecord::Migration
  def change
    remove_index :lessons, column: [:course_id, :position]
  end
end
