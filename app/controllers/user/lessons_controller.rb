class User::LessonsController < User::AuthenticateController
  before_action :load_lesson, except: [:new, :create]
  authorize_resource

  def new
    @lesson = course.lessons.build
  end

  def create
    @lesson = course.lessons.build(homework_params)
    if @lesson.save

      redirect_to user_course_path(course)
    else

      redirect_to :back
    end
  end

  def update
    if @lesson.update(homework_params)

      redirect_to user_course_path(course)
    else

      redirect_to :back
    end
  end

  def show
    authorize! :manage, @lesson
  end

  def destroy
    @lesson.destroy

    redirect_to user_course_path(course)
  end

  def homework_params
    params.require(:lesson).permit(:title, :description, :image, :lecture_notes, :homework_text)
  end

  def load_lesson
    @lesson = course.lessons.find(params[:id])
  end

  def course
    @course ||= Course.find(params[:course_id])
  end
end
