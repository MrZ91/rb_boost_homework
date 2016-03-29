class User::AdvancementsController < User::AuthenticateController
  def index
    @advancements = Advancement.where(lesson_id: params[:lesson_id])
  end
end
