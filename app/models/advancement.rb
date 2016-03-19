class Advancement < ActiveRecord::Base
  include AASM

  after_create { proceed_feedback Newsfeed::KIND_ADVANCEMENT_CREATED }

  validates :version, presence:  true
  validates :user_id, uniqueness: { scope: :lesson_id }

  belongs_to :lesson, -> { includes :course }
  belongs_to :user, -> { includes :profile }

  aasm column: :state do
    state :pending, initial: true
    state :approved
    state :rejected

    event :approve, after: :proceed_approved_news do
      transitions to: :approved
    end

    event :reject, after: :proceed_rejected_news do
      transitions from:  :pending, to: :rejected
    end

    event :resend, after: :proceed_resended_feedback do
      transitions from: :rejected, to: :pending
    end
  end

  private

  def proceed_feedback(kind)
    user.feedbacks.create(recipient: lesson.course.user, trackable: self, kind: kind)
  end

  def proceed_news(kind)
    user.news.create(owner: lesson.course.user, trackable: self, kind: kind)
  end

  def proceed_approved_news
    proceed_news(Newsfeed::KIND_ADVANCEMENT_APPROVED)
  end

  def proceed_rejected_news
    proceed_news(Newsfeed::KIND_ADVANCEMENT_REJETED)
  end

  def proceed_resended_feedback
    proceed_feedback(Newsfeed::KIND_ADVANCEMENT_RESENDED)
  end
end
