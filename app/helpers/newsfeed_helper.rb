module NewsfeedHelper
  KIND_PATH = %w(
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
      
  KIND_NAME = %w(
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

  SUBJECT = [
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

  def newsfeed_template_path(kind)
    'user/newsfeeds/partials/'.concat newsfeed_path_for(kind)
  end

  def template_path_for_kind(kind)
    "#{newsfeed_template_path(kind)}/#{newsfeed_name_for_kind(kind)}"
  end

  def newsfeed_path_for(kind)
    KIND_PATH[kind]
  end

  def newsfeed_name_for_kind(kind)
    KIND_NAME[kind]
  end

  def mail_subject_for_kind(kind)
    SUBJECT[kind]
  end

  def mail_template_name_for_kind(kind)
    newsfeed_name_for_kind(kind)
  end

  def mail_template_path_for_kind(kind)
    'notification_mailer/'.concat newsfeed_path_for(kind)
  end
end
