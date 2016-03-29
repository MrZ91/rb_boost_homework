class User::LessonsController < User::AuthenticateController
  before_action :find_course, only: [:create, :show, :destroy]

  def create
    @lesson = @course.lessons.build(homework_params)

    if @lesson.save

      redirect_to user_course_path(@course)
    else

      redirect_to :back
    end
  end

  def show
    @lesson = @course.lessons.find(params[:id])
  end

  def destroy
    lesson = @course.lessons.find(params[:id])
    lesson.destroy

    redirect_to user_course_path(@course)
  end

  def homework_params
    params.require(:lesson).permit(:title, :description, :image, :lecture_notes, :homework_text)
  end

  def find_course
    @course = Course.find(params[:course_id])
  end
end
