class NotificationMailer < ApplicationMailer
  include NewsfeedHelper
  default from: 'rubyboost_notification@ruby.mail'

  PATH = NewsfeedAndMailService::PATH

  NAME = NewsfeedAndMailService::NAME

  SUBJECT = NewsfeedAndMailService::SUBJECT

  def notification(newsfeed)
    @newsfeed = newsfeed
    mail(template_path: "notification_mailer/#{PATH[newsfeed.kind]}",
         template_name: NAME[newsfeed.kind],
         to: newsfeed.recipient.email,
         subject: SUBJECT[newsfeed.kind])
  end
end
