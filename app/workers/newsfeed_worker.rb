class NewsfeedWorker
  include Sidekiq::Worker

  sidekiq_options queue: 'newsfeed', failure: true, retry: true

  def perform(params={}, with_mailing=false)
    notification = Newsfeed.create(params)
    sleep 10

    NotificationMailer.notification(notification).deliver if with_mailing
  end
end
