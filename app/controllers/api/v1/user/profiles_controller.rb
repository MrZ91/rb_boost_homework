class Api::V1::User::ProfilesController < Api::V1::User::BaseController
  before_action :configure_profile, except: [:update]

  def update
    if profile_params.present?
      profile = current_user.with_profile

      render(json: { success: true, message: 'Profile updated' }, status: 202) unless profile.update(profile_params)

      respond_with_error(profile, 409)
    else

      render json: { success: false, errors: 'Wrong type of request' }, status: 400
    end
  end

  private

  def configure_profile
    return if profile_configured?

    render json: { success: false, error_messages: 'Configure profile first' }, status: 403
  end

  def profile_configured?
    user_signed_in? && current_user.profile.present?
  end

  def profile_params
    params.require(:user).permit(:first_name, :last_name)
  end
end
