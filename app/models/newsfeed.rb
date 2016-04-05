class Newsfeed < ActiveRecord::Base
  KIND_COURSE_VISIBILITY = 0
  KIND_USER_SUBSCRIBED = 1
  KIND_USER_EXCLUDED = 2
  KIND_LESSON_CREATED = 3
  KIND_ADVANCEMENT_CREATED = 4
  KIND_ADVANCEMENT_APPROVED = 5
  KIND_ADVANCEMENT_REJETED = 6
  KIND_ADVANCEMENT_RESENDED = 7
  KIND_LESSON_MATERIALS_LOADED = 8
  KIND_LESSON_BEGIN_IN_ONE_DAY = 9

  belongs_to :recipient, class_name: 'User', foreign_key: :recipient_id
  belongs_to :owner,     class_name: 'User', foreign_key: :owner_id
  belongs_to :trackable, polymorphic: true

  scope :recent, -> { order('updated_at DESC') }

  def self.update_or_create(params={})
    newsfeed = Newsfeed.where(params).first
    newsfeed.present? ? newsfeed.update!(params) : Newsfeed.create(params)
  end
end
