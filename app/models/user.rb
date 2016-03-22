class User < ActiveRecord::Base
  rolify

  include Omniauthable

  after_save :apply_default_role

  devise :database_authenticatable, :registerable, :rememberable, :validatable,
         :omniauthable, omniauth_providers: [:facebook, :twitter]

  has_many :subscriptions, through: :course_users, source: :course
  has_many :course_users, -> { active }, dependent: :destroy
  has_many :courses,         dependent: :destroy
  has_many :social_profiles, dependent: :destroy
  has_many :advancements,    dependent: :destroy
  has_many :news,      class_name: 'Newsfeed', foreign_key: :recipient_id, dependent: :destroy
  has_many :feedbacks, class_name: 'Newsfeed', foreign_key: :owner_id, dependent: :destroy
  has_one  :profile, dependent: :destroy

  accepts_nested_attributes_for :profile
  delegate :first_name, :last_name, to: :profile, allow_nil: true

  validates_associated :profile

  def with_profile
    build_profile if profile.nil?
    self
  end

  def subscribed_to?(course)
    course_users.exists?(course_id: course.id)
  end

  def advancement_in?(lesson)
    !advancements.where(lesson_id: lesson.id).count.zero?
  end

  private

  def apply_default_role
    add_role :apprentice
  end
end
