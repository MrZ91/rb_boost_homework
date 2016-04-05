class User::AdvancementsController < User::AuthenticateController
  before_action :find_advancement, only: [:show]
  def index
    authorize! :manage, lesson
    @advancements = lesson.advancements.includes(:user)
  end

  def show
    authorize! :manage, lesson
  end

  private

  def course
    @course ||= Course.find_by(id: params[:course_id])
  end

  def lesson
    @lesson ||= course.lessons.find_by(id: params[:lesson_id])
  end

  def find_advancement
    @advancement = lesson.advancements.find_by(id: params[:id])
  end
end
