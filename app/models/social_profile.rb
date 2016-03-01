class SocialProfile < ActiveRecord::Base
  belongs_to :user
  validates :provider, :uid, presence: true
  validates :provider, uniqueness: { scope: :user_id }
end
