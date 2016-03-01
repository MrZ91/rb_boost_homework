class Profile < ActiveRecord::Base
  UNRESOLVED_SYMBOLS_REGEX = %r{\!|\@|\#|\$|\%|\^|\&|\*|\(|\)|\'|\"|\\|\||\/|\?|\.|\,|\=|\+|\{|\}|\[|\]}

  validates :first_name, :last_name, presence: true, format: { without: UNRESOLVED_SYMBOLS_REGEX }

  belongs_to :user
end
