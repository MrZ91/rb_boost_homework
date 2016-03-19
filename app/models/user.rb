class User < ActiveRecord::Base
  rolify

  include Omniauthable

  after_commit :apply_default_role

  devise :database_authenticatable, :registerable, :rememberable, :validatable,
         :omniauthable, omniauth_providers: [:facebook, :twitter]

  has_many :subscriptions,  through: :course_users, source: :course
  has_many :participations, through: :lessons, source: :course
  has_many :lessons,        through: :advancements
  has_many :courses,         dependent: :destroy
  has_many :course_users,    dependent: :destroy
  has_many :exclusions,      dependent: :destroy
  has_many :social_profiles, dependent: :destroy
  has_many :advancements,    dependent: :destroy
  has_many :news,      class_name: 'Newsfeed', foreign_key: :recipient_id
  has_many :feedbacks, class_name: 'Newsfeed', foreign_key: :owner_id
  has_one  :profile, dependent: :destroy

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

  private

  def apply_default_role
    add_role :apprentice
  end
end
