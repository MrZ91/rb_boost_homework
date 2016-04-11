class User::CallbacksController < Devise::OmniauthCallbacksController
  def facebook
    process_callback
  end

  def twitter
    process_callback
  end

  private

  def process_callback
    oauth_data = request.env['omniauth.auth']

    sign_in_with_oauth_data(oauth_data.provider, oauth_data.uid) unless user_signed_in?
    current_user.register_social_profile(oauth_data.provider, oauth_data.uid)

    redirect_to current_user
  end

  def sign_in_with_oauth_data(provider, uid)
    user = User.find_or_create_with_oauth(provider, uid)
    sign_in :user, user
  end
end
