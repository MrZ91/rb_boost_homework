class AdvancementController < ApplicationController
  before_action :find_lesson
  before_action :authenticate_user!
  before_action :configure_profile

  def create
    render 'advancement/error' if current_user.advancement_in?(@lesson)
    @lesson.advancements.create(version: params[:advancement][:version], user_id: current_user.id)
  end

  private

  def find_lesson
    @lesson = Lesson.find(params[:lesson_id])
  end
end
