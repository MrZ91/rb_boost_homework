class User::ProfileController < User::AuthenticateController
  layout 'devise'

  def update
    if current_user.update(user_profile_params)
      sign_in :user, current_user, bypass: true

      redirect_to current_user
    else
      # Some error messages need to be placed here!

      render :edit
    end
  end

  private

  def user_profile_params
    params.require(:user).permit(:email, :password,
                                 :password_confirmation, :current_password,
                                 profile_attributes: [:first_name, :last_name])
  end
end
