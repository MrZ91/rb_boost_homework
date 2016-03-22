class LessonsController < ApplicationController
  before_action :find_course, :load_lesson
  authorize_resource

  def show
  end

  def find_course
    @course = Course.find(params[:course_id])
  end

  def load_lesson
    @lesson = @course.lessons.find(params[:id])
  end

  def advancement
    @advancement ||= @lesson.advancements.build
  end
  helper_method :advancement

  def not_authorized_message
    'You not authorized to visit this lesson'
  end
end
