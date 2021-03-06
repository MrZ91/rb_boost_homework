class User::LessonsSortingController < User::AuthenticateController
  before_action :find_course

  def sort
    authorize! :crud, @course
    @course.sort_lessons_by_order params['homework-list']
    redirect_to user_course_path(@course)
  end

  private

  def find_course
    @course = current_user.courses.find_by(id: params[:id])
  end
end
