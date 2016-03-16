class UserController < ApplicationController
  before_action :authenticate_user!

  def show
    @user = User.find(id: params[:id])
  end
end
