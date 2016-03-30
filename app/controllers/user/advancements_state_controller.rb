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

  def course
    @course ||= current_user.courses.find_by(id: params[:course_id])
  end

  def lesson
    @lesson ||= course.lessons.find_by(id: params[:lesson_id])
  end

  def find_advancement
    @advancement = lesson.advancements.find_by(id: params[:advancement_id])
  end
end
