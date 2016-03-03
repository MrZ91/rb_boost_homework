class UserController < ApplicationController
  before_action :authenticate_user!

  def show
    @user = User.find_by id: params[:id]
  end

  def course_params
    params.require(:user).permit(:email, :password, :password_confirmation, profile_attributes: [:first_name,
                                                                                                 :last_name])
  end
end
