class Api::V1::User::CoursesController < Api::V1::User::BaseController
  def index
    courses = User.find(params[:user_id]).courses.visible

    respond_with_success courses
  end
end
