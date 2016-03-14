class Advancement < ActiveRecord::Base
  include AASM

  validates :version, presence:  true
  validates :user_id, uniqueness: { scope: :lesson_id }

  belongs_to :lesson, -> { includes :course }
  belongs_to :user, -> { includes :profile }

  aasm column: :state do
    state :pending, initial: true
    state :approved
    state :rejected

    event :approve do
      transitions to: :approved
    end

    event :reject do
      transitions from:  :pending, to: :rejected
    end

    event :resend do
      transitions from: :rejected, to: :pending
    end
  end
end
