class User::SubscriptionsController < User::AuthenticateController
  before_action :find_course

  COURSES_ON_PAGE = 9

  def create
    @course.subscribers << current_user
  end

  def destroy
    @course.course_users.where(user_id: current_user.id).first.destroy!
  end

  def show
    @subscriptions=current_user.subscriptions.page(params[:page]).per(COURSES_ON_PAGE)
  end

  def find_course
    @course = current_user.courses.find_by(id: params[:course_id])
  end
end
