class User::ProfileController < ApplicationController
  before_action :authenticate_user!
  layout 'devise'

  def signed_up_with_social
    current_user.with_profile
  end

  def update
    update_with_render :edit
  end

  def edit_signed_up_with_social
    update_with_render :signed_up_with_social
  end

  private

  def profile_params
    params.require(:user).permit(:email, :password,
                                 :password_confirmation, :current_password,
                                 profile_attributes: [:first_name, :last_name])
  end

  def update_with_render(to)
    if current_user.update(profile_params)
      sign_in :user, current_user, bypass: true

      redirect_to current_user
    else
      # Some error messages need to be placed here!

      render to
    end
  end
end
