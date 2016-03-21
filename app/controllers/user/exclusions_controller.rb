class User::ExclusionsController < User::AuthenticateController
  before_action :find_course, :load_course_user

  def update
    authorize! :update, @course_user
    @course_user.toggle(:active).save!
  end

  def find_course
    @course = Course.find(params[:courses_id])
  end

  def load_course_user
    @course_user = @course.course_users.find_by(user_id: user.id)
  end

  def user
    @user ||= User.find(params[:id])
  end
  helper_method :user
end
