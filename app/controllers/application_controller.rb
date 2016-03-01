class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :configure_profile, unless: :devise_controller?

  protect_from_forgery with: :exception

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) do |user|
      user.permit(:email, :password, :password_confirmation, profile_attributes: [:first_name, :last_name])
    end

    devise_parameter_sanitizer.for(:account_update) do |user|
      user.permit(:email, :password, :password_confirmation, :current_password, profile_attributes: [:first_name,
                                                                                                     :last_name])
    end
  end

  def select_layout
    devise_controller? ? 'devise' : 'application'
  end

  def configure_profile
    return unless user_signed_in? && current_user.signed_up_with_social
    redirect_to user_signed_up_with_social_path
  end
end
