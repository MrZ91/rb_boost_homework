class NotificationMailer < ApplicationMailer
  include NewsfeedHelper
  default from: 'rubyboost_notification@ruby.mail'

  def notification(newsfeed)
    @newsfeed = newsfeed
    mail(template_path: mail_template_path_for_kind(newsfeed.kind),
         template_name: mail_template_name_for_kind(newsfeed.kind),
         to: newsfeed.recipient.email,
         subject: mail_subject_for_kind(newsfeed.kind))
  end
end
