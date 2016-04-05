class Advancement < ActiveRecord::Base
  include AASM

  after_commit :proceed_created_feedback, on: :create

  validates :version, presence:  true
  validates :user_id, uniqueness: { scope: :lesson_id }

  belongs_to :lesson
  belongs_to :user
  has_many :feedbacks, class_name: 'Newsfeed', as: :trackable, dependent: :destroy

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
    NewsfeedWorker.perform_async(owner_id: user.id, recipient_id:  lesson.course.user.id,
                                 trackable_type: self.class.name, trackable_id: id,
                                 kind: kind)
  end

  def proceed_news(kind, with_mailing=false)
    NewsfeedWorker.perform_async({ owner_id: lesson.course.user.id, recipient_id:  user.id,
                                   trackable_type: self.class.name, trackable_id: id, kind: kind },
                                 with_mailing: with_mailing)
  end

  def proceed_approved_news
    proceed_news(Newsfeed::KIND_ADVANCEMENT_APPROVED, true)
  end

  def proceed_rejected_news
    proceed_news(Newsfeed::KIND_ADVANCEMENT_REJETED, true)
  end

  def proceed_resended_feedback
    proceed_feedback(Newsfeed::KIND_ADVANCEMENT_RESENDED)
  end

  def proceed_created_feedback
    proceed_feedback Newsfeed::KIND_ADVANCEMENT_CREATED
  end
end
