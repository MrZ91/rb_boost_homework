class CourseNewsfeedWorker
  include Sidekiq::Worker

  sidekiq_options queue: 'newsfeed', failure: true, retry: true

  def perform(params={})
    params[:trackable_type] = 'Course'
    Newsfeed.update_or_create(params)
  end
end
