class Lesson < ActiveRecord::Base
  default_scope -> { order('position ASC') }

  before_create :set_position
  before_destroy :reduce_subsequent_position

  validates :title, length: { maximum: 50 }, presence:  true
  validates :description, :lecture_notes, presence:  true

  belongs_to :course
  has_many :advancements, dependent: :destroy
  has_many :users, through: :advancements

  mount_uploader :image, LessonImageUploader

  private

  def set_position
    self.position += course_lessons_count
  end

  def course_lessons_count
    Lesson.where(course_id: course_id).count ? Lesson.where(course_id: course_id).count : 0
  end

  def reduce_subsequent_position
    subsequent_lessons = Lesson.all.where(course_id: course_id).where("position > #{position}")
    update!(position: 0)
    subsequent_lessons.each do |lesson|
      lesson.decrement!(:position)
    end
  end
end
