class User::AuthenticateController < ApplicationController
  before_action :authenticate_user!
  before_action :configure_profile
end
