class CreateCourseUsers < ActiveRecord::Migration
  def change
    create_table :course_users do |t|
      t.integer :user_id, null: false
      t.integer :course_id, null: false

      t.timestamp null: false
    end

    add_index :course_users, [:user_id, :course_id], unique: true
  end
end
