class User::LessonsController < User::AuthenticateController
  before_action :find_course, only: [:create, :show, :destroy]

  def create
    @lesson = @course.lessons.new(homework_params)
    @lesson.save

    redirect_to user_course_path(@course)
  end

  def show
    @lesson = @course.lessons.find_by(id: params[:id])
  end

  def destroy
    lesson = @course.lessons.find_by(id: params[:id])
    lesson.destroy
    redirect_to user_course_path(@course)
  end

  def homework_params
    params.require(:lesson).permit(:title, :description, :image, :lecture_notes, :homework_text)
  end

  def find_course
    @course = Course.find_by(id: params[:course_id])
  end
end
