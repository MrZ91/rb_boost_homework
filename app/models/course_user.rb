class CourseUser < ActiveRecord::Base
  before_destroy :delete_feedbacks
  after_commit :proceed_subscribed_feedback, on: :create
  after_update :proceed_updated_feedback

  belongs_to :user
  belongs_to :course
  scope :active, -> { where(active: true) }

  validates :course_id, uniqueness: { scope: :user_id }

  private

  def proceed_updated_feedback
    Newsfeed.update_or_create(owner: course.user, recipient: user, trackable: self,
                              kind: Newsfeed::KIND_USER_EXCLUDED)
  end

  def proceed_subscribed_feedback
    NewsfeedWorker.perform_async(owner_id: user.id, recipient_id: course.user.id,
                                 trackable_type: 'CourseUser', trackable_id: id,
                                 kind: Newsfeed::KIND_USER_SUBSCRIBED)
  end

  def delete_feedbacks
    Newsfeed.where(trackable: self).each(&:destroy)
  end
end
