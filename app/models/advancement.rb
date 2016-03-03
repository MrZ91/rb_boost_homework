class Advancement < ActiveRecord::Base
  validates :version, presence:  true
  validates :user_id, uniqueness: { scope: :lesson_id }

  belongs_to :lesson
  belongs_to :user
end
