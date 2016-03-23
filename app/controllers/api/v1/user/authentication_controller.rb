class Api::V1::User::AuthenticationController < Api::V1::BaseController
  def show
    if user_sign_in_params.present?
      sign_in_with_user
    elsif params[:social_provider].present? && params[:token].present?
      send("sign_in_with_#{params[:social_provider]}")
    else

      render json: { success: false, errors: 'Wrong type of request' }, status: 400
    end
  end

  def create
    if user_sign_up_params.present?

      sign_up_with_user
    elsif params[:social_provider].present? && params[:token].present?
      send("sign_in_up_#{params[:social_provider]}")
    else

      render json: { success: false, errors: 'Wrong type of request' }, status: 400
    end
  end

  private

  def sign_in_with_facebook
    response = build_facebook_response(params[:token])

    uid = JSON.parse(response.body)['id']
    user = User.find_with_oauth('facebook', uid)

    if user.present?
      sign_in user, store: false

      respond_with_success(user.authentication_token)
    else
      respond_with_not_found
    end
  end

  def sign_up_with_facebook
    response = build_facebook_response(params[:token])

    uid = JSON.parse(response.body)['id']
    user = User.find_or_create_with_oauth('facebook', uid)
    sign_in user, store: false

    respond_with_success(user.authentication_token)
  end

  def sign_in_with_twitter
    uid = params[:token].split('-').first
    user = User.find_with_oauth('twitter', uid)

    if user.present?
      sign_in user, store: false

      respond_with_success(user.authentication_token)
    else
      respond_with_not_found
    end
  end

  def sign_up_with_twitter
    uid = params[:token].split('-').first
    user = User.find_or_create_with_oauth('twitter', uid)
    sign_in user, store: false

    respond_with_success(user.authentication_token)
  end

  def sign_in_with_user
    user = User.find_by_email(params[:user][:email])

    respond_with_not_found unless user.present?

    raise NotAuthorized unless user.valid_password?(params[:user][:password])
    sign_in user, store: false

    respond_with_success(user.authentication_token)
  end

  def sign_up_with_user
    user = User.new(user_sign_up_params)

    if user.save

      respond_with_success(user.authentication_token)
    else

      respond_with_error(user)
    end
  end

  def user_sign_up_params
    params.require(:user).permit(:email, :password, :password_confirmation)
  end

  def user_sign_in_params
    params.require(:user).permit(:email, :password)
  end
end
