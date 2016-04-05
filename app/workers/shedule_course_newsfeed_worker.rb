class SheduleCourseNewsfeedWorker
  include Sidekiq::Worker

  sidekiq_options queue: 'shedule_newsfeed', failure: true

  def perform(course_id, kind)
    course = Course.find course_id
    owner_id = course.user.id
    subscribers_ids = course.subscribers.pluck(:id)
    subscribers_ids.each do |subscriber_id|
      CourseNewsfeedWorker.perform_async(owner_id: owner_id, recipient_id: subscriber_id,
                                         trackable_id: course_id, kind: kind)
    end
  end
end
