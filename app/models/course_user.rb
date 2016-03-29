class CourseUser < ActiveRecord::Base
  belongs_to :user
  belongs_to :course
  scope :active, -> { where(active: true) }

  validates :course_id, uniqueness: { scope: :user_id }

  def active?
    active
  end
end
