class AdvancementController < ApplicationController
  skip_before_action :configure_profile
  before_action :find_lesson
  # rubocop:disable Metrics/AbcSize
  def create
    advancement = Advancement.new(version: params[:advancement][:version],
                                  user_id: current_user.id, lesson_id: @lesson.id)
    # rubocop:enable Metrics/AbcSize
    unless advancement.save
      if current_user.advancements.where(lesson_id: @lesson.id).count.zero?
        redirect_to :back
      else
        render 'advancement/error'
      end
    end
  end

  private

  def find_lesson
    @lesson = Lesson.find_by(id: params[:lesson_id])
  end
end
