class User::CourseVisibilityController < User::AuthenticateController
  before_action :find_course

  def update
    @course.toggle(:visible).save!
  end

  def find_course
    @course = current_user.courses.find_by(id: params[:course_id])
  end
end
