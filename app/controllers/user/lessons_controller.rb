class User::LessonsController < User::AuthenticateController
  before_action :find_course
  before_action :find_lesson

  def new
    @lesson = @course.lessons.build
  end

  def create
    @lesson = @course.lessons.new(homework_params)
    if @lesson.save

      redirect_to user_course_path(@course, anchor: 'homework')
    else
      render :new
    end
  end

  def update
    if @lesson.update(homework_params)

      redirect_to user_course_lesson_path(@lesson)
    else

      render :edit
      # Some error messages need to be placed here!
    end
  end

  def destroy
    @lesson.destroy
    redirect_to user_course_path(@course, anchor: 'homework')
  end

  private

  def homework_params
    params.require(:lesson).permit(:title, :description, :image, :lecture_notes, :homework_text, :date_of)
  end

  def find_course
    @course = Course.find(params[:course_id])
  end

  def find_lesson
    @lesson = @course.lessons.find_by(id: params[:id])
  end
end
