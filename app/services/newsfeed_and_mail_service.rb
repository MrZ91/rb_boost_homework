class NewsfeedAndMailService
  PATH = %w(
    course
    user
    user
    lesson
    advancement
    advancement
    advancement
    advancement
    lesson
    lesson ).freeze

  NAME = %w(
    visibility
    subscribed
    excluded
    created
    created
    approved
    rejected
    resended
    materials_loaded
    begin_in_day ).freeze

  SUBJECT = [
    'not_in_mailing',
    'not_in_mailing',
    'not_in_mailing',
    'not_in_mailing',
    'not_in_mailing',
    'Your advancement was approved.',
    'Your advancement was rejected.',
    'not_in_mailing',
    'Materials for lesson loaded.',
    'Lesson will begin in one day.'].freeze

  def self.template_path_for_kind(kind)
    "user/newsfeeds/partials/#{PATH[kind]}/#{NAME[kind]}"
  end
end
