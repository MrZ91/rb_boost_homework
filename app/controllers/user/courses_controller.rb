class User::CoursesController < User::AuthenticateController
  before_action :find_course, only: [:edit, :show, :update, :destroy]

  protect_from_forgery with: :exception

  COURSES_ON_CABINET_PAGE = 9

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

  def edit
  end

  def new
    @course = current_user.courses.build
  end

  def show
    @subscribers = @course.subscribers
  end

  def update
    if @course.update(course_params)
      redirect_to @course
    else
      render :edit
      # Some error messages need to be placed here!
    end
  end

  def destroy
    @course.destroy

    redirect_to courses_path
  end

  private

  def course_params
    params.require(:course).permit(:title, :description, :image)
  end

  def find_course
    @course = current_user.courses.find_by(id: params[:id])
  end
end
