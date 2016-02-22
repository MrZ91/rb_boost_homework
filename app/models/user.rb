class User < ActiveRecord::Base
  NAME_REGEX = /\A[A-Z]\w+|\A[A-Z]\w+\s[A-Z]\w+/
  EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

  devise :database_authenticatable, :registerable,
         :rememberable, :validatable

  has_many :courses

  validates :first_name, :last_name, presence: true, format: NAME_REGEX
  validates :password, confirmation: true, presence: true, length: 6..22,
            format: { without: /\b(\w)\1+\b/i }
  validates :password, format: { with: /\A\w+\z/i }

  validates :password_confirmation, presence: true
  validates :email, presence: true, format: EMAIL_REGEX, uniqueness: true
end
