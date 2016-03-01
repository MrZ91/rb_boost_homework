class Course < ActiveRecord::Base
  belongs_to :user

  validates :title, length: { maximum: 50 }, presence:  true
  validates :description, presence:  true

  mount_uploader :image, CourseImageUploader
end
