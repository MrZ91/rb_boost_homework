class SheduleLessonNewsfeedWorker
  include Sidekiq::Worker

  sidekiq_options queue: 'shedule_newsfeed', failure: true

  def perform(lesson_id, kind, with_mailing=false)
    lesson = Lesson.find lesson_id
    owner_id = lesson.course.user.id
    subscribers_ids = lesson.course.subscribers.pluck(:id)
    subscribers_ids.each do |subscriber_id|
      NewsfeedWorker.perform_async({ owner_id: owner_id, recipient_id: subscriber_id,
                                     trackable_type: 'Lesson', trackable_id: lesson_id,
                                     kind: kind }, with_mailing)
    end
  end
end
