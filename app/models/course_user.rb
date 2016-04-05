class CourseUser < ActiveRecord::Base
  after_commit :proceed_feedback, on: :create
  before_destroy :delete_feedbacks

  belongs_to :user
  belongs_to :course
  scope :active, -> { where(active: true) }

  validates :course_id, uniqueness: { scope: :user_id }

  def active?
    active
  end

  private

  def proceed_feedback
    NewsfeedWorker.perform_async(owner_id: user.id, recipient_id: course.user.id,
                                 trackable_type: 'CourseUser', trackable_id: id,
                                 kind: Newsfeed::KIND_USER_SUBSCRIBED)
  end

  def delete_feedbacks
    Newsfeed.where(trackable: self).each(&:destroy)
  end
end
