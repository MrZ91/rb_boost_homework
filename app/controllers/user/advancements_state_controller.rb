class User::AdvancementsStateController < User::AuthenticateController
  before_action :find_advancement, only: [:reject, :approve]

  def approve
    @advancement.approve!

    redirect_to :back
  end

  def reject
    @advancement.reject!

    redirect_to :back
  end

  private

  def redirect_to_advancement
    redirect_to user_course_lesson_advancement_path(course, lesson, @advancement)
  end

  def course
    @course ||= Course.find_by(id: params[:course_id])
  end

  def lesson
    @lesson ||= course.lessons.find_by(id: params[:lesson_id])
  end

  def find_advancement
    @advancement = lesson.advancements.find_by(id: params[:advancement_id])
  end
end
