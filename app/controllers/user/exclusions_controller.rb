class User::ExclusionsController < User::AuthenticateController
  after_action :proceed_news
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

  def proceed_news
    @user.news.create(owner: @course.user, trackable: @course_user, kind: Newsfeed::KIND_USER_EXCLUDED)
  end
end
