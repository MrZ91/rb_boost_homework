class UserController < ApplicationController
  before_action :authenticate_user!

  COURSES_ON_PAGE = 9

  def cabinet
    @my_courses = current_user.courses.page(params[:page]).per(COURSES_ON_PAGE)
  end

  def show
    @user = User.find_by id: params[:id]
  end
end
