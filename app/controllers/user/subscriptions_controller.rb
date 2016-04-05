class User::SubscriptionsController < User::AuthenticateController
  before_action :load_course, only: [:create, :destroy]

  COURSES_ON_PAGE = 3

  def create
    authorize! :subscribe, @course
    @course.subscribers << current_user
  end

  def destroy
    authorize! :unsubscribe, @course
    @course.course_users.find_by(user_id: current_user.id).destroy!
  end

  def show
    @subscriptions = current_user.subscriptions.page(params[:page]).per(COURSES_ON_PAGE)
  end

  private

  def load_course
    @course = Course.find(params[:course_id])
  end

  def not_authorized
    render 'user/exclusions/error'
  end
end
