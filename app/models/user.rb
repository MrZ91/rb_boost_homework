class User < ActiveRecord::Base
  include Omniauthable

  devise :database_authenticatable, :registerable, :rememberable, :validatable,
         :omniauthable, omniauth_providers: [:facebook, :twitter]

  has_many :courses, dependent: :destroy
  has_one :profile, dependent: :destroy
  has_many :social_profiles, dependent: :destroy

  accepts_nested_attributes_for :profile
  delegate :first_name, :last_name, to: :profile

  validates_associated :profile

  def with_profile
    build_profile if profile.nil?
    self
  end
end
