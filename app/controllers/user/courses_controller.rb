class User
  class CoursesController < ApplicationController
    protect_from_forgery with: :exception

    def create
      @course = current_user.courses.new(course_params)

      if @course.save
        redirect_to @course
      else
        render :new
      end
    end

    def edit
      @course = current_user.courses.find_by(id: params[:id])
    end

    def new
      @course = current_user.courses.build
    end

    def show
      @course = current_user.courses.find_by(id: params[:id])
    end

    def update
      @course = current_user.courses.find_by(id: params[:id])

      if @course.update(course_params)
        redirect_to @course
      else
        render :edit
        # Some error messages need to be placed here!
      end
    end

    def destroy
      course = current_user.courses.find_by(id: params[:id])
      course.destroy

      redirect_to courses_path
    end

    private

    def course_params
      params.require(:course).permit(:title, :description, :image)
    end
  end
end
