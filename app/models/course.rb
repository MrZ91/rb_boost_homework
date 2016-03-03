class Course < ActiveRecord::Base
  belongs_to :user
  has_many :course_users, dependent: :destroy
  has_many :subscribers, through: :course_users, source: :user

  validates :title, length: { maximum: 50 }, presence:  true
  validates :description, presence:  true

  mount_uploader :image, CourseImageUploader
end
