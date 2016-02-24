class CoursesController < ApplicationController
  protect_from_forgery with: :exception

  COURSES_ON_PAGE = 9

  def index
    @courses = Course.page(params[:page]).per(COURSES_ON_PAGE)
  end

  def show
    @course = Course.find_by(id: params[:id])
  end
end
