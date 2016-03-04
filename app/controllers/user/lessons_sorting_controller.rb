class User::LessonsSortingController < User::AuthenticateController
  before_action :find_course

  def sort
    order = params['homework-list']
    @course.lessons.each { |l| l.update(position: (order.index(l.id.to_s) + 1)) }
    redirect_to user_course_path(@course)
  end

  private

  def find_course
    @course = Course.find_by(id: params[:id])
  end
end
