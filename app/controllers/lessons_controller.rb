class LessonsController < ApplicationController
  before_action :find_course

  def show
    @lesson = @course.lessons.find(params[:id])
  end

  def homework_params
    params.require(:lesson).permit(:title, :description, :image, :lecture_notes, :homework_text)
  end

  def find_course
    @course = Course.find(params[:course_id])
  end
end
