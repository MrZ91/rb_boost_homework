class User::AuthenticateController < ApplicationController
  before_action :authenticate_user!
end
