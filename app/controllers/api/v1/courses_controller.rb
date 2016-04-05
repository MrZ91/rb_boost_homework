class Api::V1::CoursesController < Api::V1::BaseController
  def index
    courses = Course.visible

    respond_with_success courses
  end
end
