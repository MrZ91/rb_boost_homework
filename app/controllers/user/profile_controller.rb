class User::ProfileController < ApplicationController
  skip_before_action :configure_profile

  layout 'devise'

  def signed_up_with_social
  end

  def edit_signed_up_with_social
    current_user

    if current_user.update(profile_params)

      current_user.social_profiles.each do |social_profile|
        social_profile.update(signed_up_with_social: false)
      end
      sign_in :user, current_user, bypass: true

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
