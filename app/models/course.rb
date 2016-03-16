class Course < ActiveRecord::Base
  scope :visible, -> { where(visible: true) }

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

  def sort_lessons_by_order(order)
    lessons.each { |l| l.update(position: (order.index(l.id.to_s) + 1)) }
  end
end
