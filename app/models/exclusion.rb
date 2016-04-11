class Exclusion < ActiveRecord::Base
  belongs_to :user
  belongs_to :course

  validates :user_id, :course_id, presence: true
  validates :course_id, uniqueness: { scope: :user_id }
end
