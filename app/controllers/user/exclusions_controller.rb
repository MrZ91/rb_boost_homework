class User::ExclusionsController < User::AuthenticateController
  before_action :find_course

  def update
    @course.course_users.find_by(user_id: user.id).toggle(:active).save!
  end

  def find_course
    @course = Course.find(params[:courses_id])
  end

  def user
    @user ||= User.find(params[:id])
  end
  helper_method :user
end
