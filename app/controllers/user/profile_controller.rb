class User::ProfileController < ApplicationController
  before_action :authenticate_user!
  layout 'devise'

  def signed_up_with_social
    @profile = current_user.with_profile.profile
  end

  def edit
  end

  def update
    if current_user.update(profile_params)
      sign_in :user, current_user, bypass: true
      redirect_to current_user
    else
      render :edit
      # Some error messages need to be placed here!
    end
  end

  def edit_signed_up_with_social
    @profile = current_user.with_profile.profile
    if current_user.update(profile_params)

      redirect_to current_user
    else
      render :signed_up_with_social
      # Some error messages need to be placed here!
    end
  end

  private

  def profile_params
    params.require(:user).permit(:email, :password,
                                 :password_confirmation, :current_password,
                                 profile_attributes: [:first_name, :last_name])
  end
end
