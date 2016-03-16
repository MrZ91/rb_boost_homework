class User < ActiveRecord::Base
  include Omniauthable

  devise :database_authenticatable, :registerable, :rememberable, :validatable,
         :omniauthable, omniauth_providers: [:facebook, :twitter]

  has_many :courses, dependent: :destroy
  has_many :course_users, dependent: :destroy
  has_many :subscriptions, through: :course_users, source: :course
  has_many :exclusions, dependent: :destroy
  has_many :social_profiles, dependent: :destroy
  has_many :advancements, dependent: :destroy
  has_one :profile, dependent: :destroy

  accepts_nested_attributes_for :profile
  delegate :first_name, :last_name, to: :profile, allow_nil: true

  validates_associated :profile

  def with_profile
    build_profile if profile.nil?
    self
  end

  def subscribed_to?(course)
    subscriptions.exists?(id: course.id)
  end
end
