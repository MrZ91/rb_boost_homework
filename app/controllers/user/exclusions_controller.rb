class User::ExclusionsController < User::AuthenticateController
  before_action :find_course
  after_action :proceed_news

  def create
    @prohibition = @course.prohibitions.create!(user_id: user.id)
    @course.course_users.find_by(user_id: user.id).destroy
  end

  def find_course
    @course = Course.find(params[:courses_id])
  end

  def user
    @user ||= User.find(params[:id])
  end
  helper_method :user

  def proceed_news
    @user.news.create(owner: @course.user, trackable: @prohibition, kind: Newsfeed::KIND_USER_EXCLUDED)
  end
end
