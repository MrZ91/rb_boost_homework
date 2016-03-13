class User::SubscriptionsController < User::AuthenticateController
  before_action :find_course, only: [:create, :destroy]

  COURSES_ON_PAGE = 9

  def create
    if @course.prohibited_for?(current_user)
      render 'user/exclusions/error'
    else
      @course.subscribers << current_user
    end
  end

  def destroy
    @course.course_users.find_by(user_id: current_user.id).destroy!
  end

  def show
    @subscriptions = current_user.subscriptions.page(params[:page]).per(COURSES_ON_PAGE)
  end

  def find_course
    @course = Course.find_by(id: params[:course_id])
  end
end
