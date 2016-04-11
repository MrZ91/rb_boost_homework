class User::CourseVisibilityController < User::AuthenticateController
  before_action :find_course
  after_action :proceed_feedbacks

  def update
    @course.toggle(:visible).save!
  end

  private

  def find_course
    @course = current_user.courses.find_by(id: params[:course_id])
  end

  def proceed_feedbacks
    @course.proceed_feedbacks(Newsfeed::KIND_COURSE_VISIBILITY)
  end
end
