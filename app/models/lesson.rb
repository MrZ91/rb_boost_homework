class Lesson < ActiveRecord::Base
  include AASM

  default_scope -> { order('position ASC') }

  before_create :set_position
  before_destroy :reduce_subsequent_position
  after_find :check_for_performing
  after_commit :check_for_performing

  validates :title, length: { maximum: 50 }, presence:  true
  validates :description, :lecture_notes, :date_of, presence:  true
  validates :date_of, date: { after_or_equal_to: proc { Time.now } }, uniqueness: { scope: :course_id }

  belongs_to :course
  has_many :advancements, dependent: :destroy
  has_many :users, through: :advancements

  mount_uploader :image, LessonImageUploader

  aasm column: :state, skip_validation_on_save: true do
    state :expected_to_performing, initial: true
    state :awaits_material_loading
    state :materials_loaded

    event :perform do
      transitions from: :expected_to_performing, to: :awaits_material_loading
    end

    event :load_materials do
      transitions from:  :awaits_material_loading, to: :materials_loaded
    end
  end

  private

  def set_position
    self.position += course_lessons_count
  end

  def course_lessons_count
    count = course.lessons.count
    count ? count : 0
  end

  def reduce_subsequent_position
    subsequent_lessons = Lesson.all.where(course_id: course_id).where('position > ?', position)
    update!(position: 0)
    subsequent_lessons.each do |lesson|
      lesson.decrement!(:position)
    end
  end

  def check_for_performing
    return unless expected_to_performing? && DateTime.now > date_of
    perform!
  end
end
