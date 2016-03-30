class Api::V1::User::SubscriptionsController < Api::V1::User::ProfilesController
  before_action :load_course, only: [:create, :destroy]

  def index
    subscriptions = current_user.subscriptions
    respond_with_success(subscriptions)
  end

  def create
    authorize! :subscribe, @course
    @course.subscribers << current_user

    render json: { success: true, message: 'Successfully subscribed!' }, status: 201
  end

  def destroy
    authorize! :unsubscribe, @course
    @course.course_users.find_by(user_id: current_user.id).destroy!

    render json: { success: true, message: 'Successfully unsubscribed!' }, status: 202
  end

  def load_course
    @course = Course.find(params[:course_id])
  end
end
