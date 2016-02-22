class UserController < ApplicationController
  COURSES_ON_PAGE = 5

  def show
    @my_courses = current_user.courses.page(params[:page]).per(COURSES_ON_PAGE)
  end
end
