module NewsfeedHelper
  def newsfeed_template_path(kind)
    'user/newsfeeds/partials/'.concat newsfeed_path_for(kind)
  end

  def template_path_for_kind(kind)
    "#{newsfeed_template_path(kind)}/#{newsfeed_name_for_kind(kind)}"
  end

  def newsfeed_path_for(kind)
    kind_path = %w(
      course
      user
      user
      lesson
      advancement
      advancement
      advancement
      advancement
      lesson
      lesson )
    kind_path[kind]
  end

  def newsfeed_name_for_kind(kind)
    kind_name = %w(
      visibility
      subscribed
      excluded
      created
      created
      approved
      rejected
      resended
      materials_loaded
      begin_in_day )
    kind_name[kind]
  end

  def mail_subject_for_kind(kind)
    subject = [
      '0',
      '1',
      '2',
      '3',
      '4',
      'Your advancement was approved.',
      'Your advancement was rejected.',
      '7',
      'Materials for lesson loaded.',
      'Lesson will begin in one day.']
    subject[kind]
  end

  def mail_template_name_for_kind(kind)
    newsfeed_name_for_kind(kind)
  end

  def mail_template_path_for_kind(kind)
    'notification_mailer/'.concat newsfeed_path_for(kind)
  end
end
