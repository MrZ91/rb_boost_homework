class Api::V1::User::AuthenticationController < Api::V1::BaseController
  before_action :initialize_auth_service
  def show
    user = @service.authenticate_user!

    respond_with_success(user.authentication_token)
  end

  def create
    user = @service.create_user

    respond_with_success(user.authentication_token)
  end

  private

  def initialize_auth_service
    @service = APIAuthenticationService.new(params)
  end
end
