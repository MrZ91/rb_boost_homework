class User::ExclusionsController < User::AuthenticateController
  before_action :find_course

  def create
    @course.prohibitions.create!(user_id: user.id)
    @course.course_users.find_by(user_id: user.id).destroy
  end

  def find_course
    @course = Course.find_by(id: params[:courses_id])
  end

  def user
    @user ||= User.find_by(id: params[:id])
  end
  helper_method :user
end