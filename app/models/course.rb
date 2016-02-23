class Course < ActiveRecord::Base
  validates :title, length: { maximum: 50 }, presence:  true
  validates :description, presence:  true
  belongs_to :user, dependent: :destroy

  mount_uploader :image, CourseImageUploader
end
