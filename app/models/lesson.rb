class Lesson < ActiveRecord::Base
  include AASM

  scope :by_position, -> { order('position ASC') }

  before_create  :set_position
  before_destroy :reduce_subsequent_position
  after_find     :check_for_performing
  after_commit   :check_for_performing
  after_commit   :lesson_created_feedbacks, :begining_day_feedbacks, on: :create

  validates :title, length: { maximum: 50 }, presence:  true
  validates :description, :lecture_notes, :date_of, presence:  true
  validates :date_of, date: { after_or_equal_to: proc { Time.now } }, uniqueness: { scope: :course_id }

  belongs_to :course
  has_many :advancements, dependent: :destroy
  has_many :users, through: :advancements
  has_many :feedbacks, class_name: 'Newsfeed', as: :trackable, dependent: :destroy

  mount_uploader :image, LessonImageUploader

  aasm column: :state, skip_validation_on_save: true do
    state :expected_to_performing, initial: true
    state :awaits_material_loading
    state :materials_loaded

    event :perform do
      transitions from: :expected_to_performing, to: :awaits_material_loading
    end

    event :load_materials, after: :material_loaded_feedbacks do
      transitions from:  :awaits_material_loading, to: :materials_loaded
    end
  end

  private

  def set_position
    self.position += course_lessons_count
  end

  def course_lessons_count
    course.lessons.count
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

  def proceed_feedbacks(kind, with_mailing=false)
    SheduleLessonNewsfeedWorker.perform_async(id, kind, with_mailing)
  end

  def proceed_delayed_feedbacks(start_date, kind, with_mailing=false)
    if start_date > DateTime.now.days_since(1)
      SheduleLessonNewsfeedWorker.perform_in(start_date, id, kind, with_mailing)
    else
      SheduleLessonNewsfeedWorker.perform_async(id, kind, with_mailing)
    end
  end

  def material_loaded_feedbacks
    proceed_feedbacks Newsfeed::KIND_LESSON_MATERIALS_LOADED, true
  end

  def lesson_created_feedbacks
    proceed_feedbacks Newsfeed::KIND_LESSON_CREATED
  end

  def begining_day_feedbacks
    proceed_delayed_feedbacks date_of.days_ago(1), Newsfeed::KIND_LESSON_BEGIN_IN_ONE_DAY, true
  end
end
