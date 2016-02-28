class User < ActiveRecord::Base
  UNRESOLVED_SYMBOLS_REGEX = %r{\!|\@|\#|\$|\%|\^|\&|\*|\(|\)|\'|\"|\\|\||\/|\?|\.|\,|\=|\+|\{|\}|\[|\]}
  EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

  devise :database_authenticatable, :registerable, :rememberable, :validatable

  has_many :courses, dependent: :destroy

  validates :first_name, :last_name, presence: true, format: { without: UNRESOLVED_SYMBOLS_REGEX }
  validates :password, format: { without: /\b(\w)\1+\b/i }
  validates :password, format: { with: /\A\w+\z/i }
end
