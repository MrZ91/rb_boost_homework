class Course < ActiveRecord::Base
  scope :visible, -> { where(visible: true) }

  belongs_to :user
  has_many :lessons, -> { by_position }, dependent: :destroy
  has_many :course_users, dependent: :destroy
  has_many :active_course_users, -> { active }, class_name: 'CourseUser', foreign_key: :course_id
  has_many :subscribers, through: :course_users, source: :user
  has_many :active_subscribers, through: :active_course_users, source: :user

  validates :title, length: { maximum: 50 }, presence:  true
  validates :description, presence:  true

  mount_uploader :image, CourseImageUploader

  def prohibited_for?(user)
    if course_users.exists?(user_id: user.id)
      !course_users.find_by(user_id: user.id).active?
    else
      false
    end
  end

  def sort_lessons_by_order(order)
    lessons.each { |lesson| lesson.update!(position: (order.index(lesson.id.to_s) + 1)) }
  end
end
