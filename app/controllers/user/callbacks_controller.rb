class User::CallbacksController < ApplicationController
  def facebook
    process_callback
  end

  def twitter
    process_callback
  end

  def process_callback
    oauth_data = request.env['omniauth.auth']

    sign_in_with_oauth_data(oauth_data) unless user_signed_in?
    current_user.register_social_profile(oauth_data)

    redirect_to current_user
  end

  def sign_in_with_oauth_data(oauth_data)
    user = User.find_or_create_with_oauth(oauth_data)
    sign_in :user, user
  end
end
