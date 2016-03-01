class User::SubscriptionsController < User::AuthenticateController
  before_action :find_course

  def create
    @course.subscribers << current_user
  end

  def destroy
    @course.course_users.where(user_id: current_user.id).first.destroy!
  end

  def find_course
    @course = current_user.courses.find_by(id: params[:course_id])
  end
end
