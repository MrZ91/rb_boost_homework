class CoursesController < ApplicationController
  protect_from_forgery with: :exception
  skip_before_action :configure_profile

  COURSES_ON_PAGE = 9

  def index
    @courses = Course.where(visible:true).page(params[:page]).per(COURSES_ON_PAGE)
  end

  def show
    @subscribers = course.subscribers
  end

  def course
    @course ||= Course.find_by(id: params[:id])
  end
  helper_method :course
end
