class Course < ActiveRecord::Base
  belongs_to :user
  has_many :lessons, dependent: :destroy
  has_many :course_users, dependent: :destroy
  has_many :subscribers, through: :course_users, source: :user
  has_many :prohibitions, class_name: 'Exclusion', foreign_key: :course_id, dependent: :destroy

  validates :title, length: { maximum: 50 }, presence:  true
  validates :description, presence:  true

  mount_uploader :image, CourseImageUploader

  def prohibited_for?(user)
    prohibitions.exists?(user_id: user.id)
  end
end
