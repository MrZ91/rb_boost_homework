class Course < ActiveRecord::Base
  validates :title, length: { maximum: 50 }
  validates_presence_of :title, :description
end