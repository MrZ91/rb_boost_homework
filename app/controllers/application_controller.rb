class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?

  protect_from_forgery with: :exception

  unless Rails.application.config.consider_all_requests_local
    rescue_from Exception, with: :redirect_with_error

    rescue_from CanCan::AccessDenied, with: :not_authorized

    rescue_from ActiveRecord::RecordNotFound,
                ActionController::RoutingError,
                ActiveRecord::RecordInvalid,
                with: :redirect_with_error
  end

  def redirect_with_error
    flash[:alert] = 'Something goes wrong'
    redirect_to root_path
  end

  def not_authorized
    flash[:alert] = not_authorized_message
    redirect_to root_path
  end

  def not_authorized_message
    'You not authorized to perform this action'
  end

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
    return if profile_configured?

    redirect_to edit_user_signed_up_with_social_path
  end

  def profile_configured?
    user_signed_in? && current_user.profile.present?
  end
  helper_method :profile_configured?
end
