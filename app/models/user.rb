class User < ActiveRecord::Base
  attr_accessor :logged_with_social
  EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

  devise :database_authenticatable, :registerable, :rememberable, :validatable,
         :omniauthable, omniauth_providers: [:facebook, :twitter]

  has_many :courses, dependent: :destroy
  has_one :profile, dependent: :destroy
  has_many :social_profiles, dependent: :destroy
  has_many :course_users
  has_many :subscriptions, through: :course_users, source: :course
  has_many :exclusions, dependent: :destroy

  accepts_nested_attributes_for :profile
  delegate :first_name, :last_name, to: :profile

  validates :password, format: { without: /\b(\w)\1+\b/i }, if: :password_required?
  validates :password, format: { with: /\A\w+\z/i }, if: :password_required?
  validates_associated :profile

  def self.find_or_create_with_oauth(oauth_data)
    find_with_oauth(oauth_data) || create_with_oauth(oauth_data)
  end

  def self.find_with_oauth(oauth_data)
    social_profile = SocialProfile.where(provider: oauth_data.provider, uid: oauth_data.uid).first
    social_profile.present? ? social_profile.user : nil
  end

  def self.create_with_oauth(oauth_data)
    pass = Devise.friendly_token(6)
    user = User.new(email: "#{SecureRandom.hex(3)}_#{oauth_data.provider}_email@social.login",
                    password: pass, password_confirmation: pass,
                    profile_attributes: { first_name: 'Change', last_name: 'This' })
    user.logged_with_social = true
    user.save!
    user
  end

  def with_profile
    build_profile if profile.nil?
    self
  end

  def register_social_profile(oauth, signed_up_with_social)
    social_profile = SocialProfile.where(provider: oauth.provider,
                                         uid: oauth.uid, user_id: id,
                                         signed_up_with_social: signed_up_with_social).first_or_create
    if social_profile.present?
      false
    else
      social_profile.update!(user_id: id)
    end

    social_profile.persisted? ? social_profile : false
  end

  def signed_up_with_social
    social_profile = social_profiles.find_by(signed_up_with_social: true)
    social_profile ? true : false
  end

  def subscribed_to?(course)
    subscriptions.exists?(id: course.id)
  end

  protected

  def password_required?
    super && !logged_with_social
  end
end
