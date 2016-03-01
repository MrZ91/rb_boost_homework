class User::CourseVisibilityController < User::AuthenticateController
  before_action :find_course

  def update
    @course.update!(visible: !@course.visible)
  end

  def find_course
    @course = current_user.courses.find_by(id: params[:course_id])
  end
end
