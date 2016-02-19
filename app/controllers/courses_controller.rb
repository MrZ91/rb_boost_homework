class CoursesController < ApplicationController
  protect_from_forgery with: :exception

  COURSES_ON_PAGE=5

  def index
    @courses = Course.page(params[:page]).per(COURSES_ON_PAGE)
  end

  def create
    @course = Course.new(course_params)

    if @course.save

      #Update image_url to ensure it is contains #{model.id} in address of file.
      if @course.update(params.require(:course).permit(:image))
        redirect_to @course
      end
    else
      render :new
    end
  end

  def edit
    @course = Course.find_by(id: params[:id])
  end

  def new
    @course = Course.new
  end

  def show
    @course = Course.find_by(id: params[:id])
  end

  def update
    @course = Course.find_by(id: params[:id])

    if @course.update(course_params)
      redirect_to @course
    else
      render :edit
      #Some error messages need to be placed here!
    end
  end

  def destroy
    course = Course.find_by(id: params[:id])
    course.destroy

    redirect_to courses_path
  end

  private

  def course_params
    params.require(:course).permit(:title, :description, :image)
  end
end
