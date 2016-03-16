class AdvancementController < ApplicationController
  before_action :find_lesson
  before_action :configure_profile

  def create
    @lesson.advancements.create(version: params[:advancement][:version], user_id: current_user.id)

    render 'advancement/error' unless current_user.advancements.where(lesson_id: @lesson.id).count.zero?
  end

  private

  def find_lesson
    @lesson = Lesson.find(params[:lesson_id])
  end
end
