class User::CoursesController < User::AuthenticateController
  before_action :load_course, only: [:edit, :show, :update, :destroy]
  authorize_resource

  protect_from_forgery with: :exception

  COURSES_ON_CABINET_PAGE = 3

  def create
    @course = current_user.courses.new(course_params)

    if @course.save

      redirect_to user_course_path(@course)
    else

      render :new
    end
  end

  def index
    @my_courses = current_user.courses.page(params[:page]).per(COURSES_ON_CABINET_PAGE)
  end

  def new
    @course = current_user.courses.build
  end

  def show
    authorize! :crud, @course
    @subscribers = @course.subscribers.includes(:profile)
  end

  def update
    if @course.update(course_params)

      redirect_to user_course_path(@course)
    else

      render :edit
      # Some error messages need to be placed here!
    end
  end

  def destroy
    @course.destroy

    redirect_to user_courses_path
  end

  private

  def not_authorized_message
    'You not authorized to manage this course'
  end

  def load_course
    @course = current_user.courses.find_by(id: params[:id])
  end

  def course_params
    params.require(:course).permit(:title, :description, :image)
  end
end
