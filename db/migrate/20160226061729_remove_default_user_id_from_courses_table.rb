class RemoveDefaultUserIdFromCoursesTable < ActiveRecord::Migration
  def change
    change_column_default :courses, :user_id, from: 0, to: nil
  end
end
