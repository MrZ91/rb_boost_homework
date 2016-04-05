class APIAuthenticationService
  def initialize(params=[])
    @params = params
  end

  def authenticate_user!
    if user_sign_in_params.present?
      find_user_with_params!
    elsif social_provider_params.present?
      public_send("find_user_with_#{@params[:social_provider]}!")
    else
      raise WrongRequest
    end
  end

  def find_user_with_params!
    user = User.find_by_email(@params[:user][:email])
    raise ActiveRecord::RecordNotFound unless user.present?
    raise NotAuthorized unless user.valid_password?(@params[:user][:password])
    user
  end

  def find_user_with_twitter!
    uid = @params[:token].split('-').first
    user = User.find_with_oauth('twitter', uid)
    raise ActiveRecord::RecordNotFound unless user.present?
    user
  end

  def find_user_with_facebook!
    response = build_facebook_response(@params[:token])
    uid = JSON.parse(response.body)['id']
    user = User.find_with_oauth('facebook', uid)
    raise ActiveRecord::RecordNotFound unless user.present?
    user
  end

  def create_user
    if user_sign_up_params.present?
      create_user_with_params
    elsif social_provider_params.present?
      public_send("create_user_with_#{@params[:social_provider]}")
    else
      raise WrongRequest
    end
  end

  def create_user_with_params
    user = User.new(user_sign_up_params)
    user.save!
    user
  end

  def create_user_with_facebook
    response = build_facebook_response(@params[:token])
    uid = JSON.parse(response.body)['id']
    User.find_or_create_with_oauth('facebook', uid)
  end

  def create_user_with_twitter
    uid = @params[:token].split('-').first
    User.find_or_create_with_oauth('twitter', uid)
  end

  private

  def facebook_connection
    Faraday.new(url: 'https://graph.facebook.com/v2.5/') do |faraday|
      faraday.request  :url_encoded
      faraday.response :logger
      faraday.adapter  Faraday.default_adapter
    end
  end

  def build_facebook_response(token)
    facebook_connection.get do |connection|
      connection.url '/me', fields: 'id'
      connection.params[:client_id] = OmnyAuthConfig['facebook']['key']
      connection.params[:client_secret] = OmnyAuthConfig['facebook']['secret']
      connection.params[:access_token] = token
    end
  end

  def user_sign_in_params
    @params.require(:user).permit(:email, :password) if @params[:user].present?
  end

  def user_sign_up_params
    @params.require(:user).permit(:email, :password, :password_confirmation) if @params[:user].present?
  end

  def social_provider_params
    @params.permit(:social_provider, :token)
  end
end
