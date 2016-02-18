class Course < ActiveRecord::Base
  validates :title, length: { maximum: 50 }, presence:  true
  validates :description, presence:  true

  paginates_per 5

  mount_uploader :image, CourseImageUploader
end
