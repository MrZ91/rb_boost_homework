class User::AdvancementsController < User::AuthenticateController
  def index
    @advancement = Advancement.where(lesson_id: params[:lesson_id])
  end
end
