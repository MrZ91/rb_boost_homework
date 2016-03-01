class User::CallbacksController < Devise::OmniauthCallbacksController
  def facebook
    process_callback
  end

  def twitter
    process_callback
  end

  def process_callback
    oauth_data = request.env['omniauth.auth']

    if user_signed_in?
      user = current_user
      user.register_social_profile(oauth_data, false)
    else
      user = sign_in_with_oauth_data(oauth_data)
      user.register_social_profile(oauth_data, true)
    end
    redirect_to current_user
  end

  def sign_in_with_oauth_data(oauth_data)
    user = User.find_or_create_with_oauth(oauth_data)
    sign_in :user, user

    user
  end
end
