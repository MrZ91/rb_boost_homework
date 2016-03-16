class CoursesController < ApplicationController
  protect_from_forgery with: :exception

  COURSES_ON_PAGE = 9

  def index
    @courses = Course.visible.includes(user: :profile).page(params[:page]).per(COURSES_ON_PAGE)
  end

  def show
    @subscribers = course.subscribers
  end

  def course
    @course ||= Course.find(params[:id])
  end
  helper_method :course
end
