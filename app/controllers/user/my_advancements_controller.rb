class User::MyAdvancementsController < User::AuthenticateController
  before_action :find_my_advancement, only: [:show, :edit, :update]

  def index
    @my_advancements = current_user.advancements.includes(:lesson)
  end

  def update
    if @my_advancement.update(version: params[:advancement][:version])
      @my_advancement.resend!

      redirect_to user_my_advancement_path(@my_advancement)
    else

      render :edit
      # Some error messages need to be placed here!
    end
  end

  private

  def find_my_advancement
    @my_advancement = current_user.advancements.find_by(id: params[:id])
  end
end
