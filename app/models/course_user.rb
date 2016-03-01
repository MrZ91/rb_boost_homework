class CourseUser < ActiveRecord::Base
  validates :course_id, uniqueness: { scope: :user_id }

  belongs_to :user
  belongs_to :course
end
