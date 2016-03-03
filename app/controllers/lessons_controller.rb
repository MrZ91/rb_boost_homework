class LessonsController < ApplicationController
  before_action :find_course, only: [:create, :show, :destroy]

  def show
    @lesson = Lesson.find_by(id: params[:id])
  end

  def homework_params
    params.require(:lesson).permit(:title, :description, :image, :lecture_notes, :homework_text)
  end

  def find_course
    @course = Course.find_by(id: params[:course_id])
  end
end
