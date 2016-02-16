class Course < ActiveRecord::Base
  validates :title, length: { maximum: 50 }
  validates_presence_of :title, :description

  paginates_per 5
end