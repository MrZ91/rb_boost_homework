class User::ProfileController < ApplicationController
  skip_before_action :configure_profile, only: [:signed_up_with_social, :edit_signed_up_with_social]

  layout 'devise', only: [:signed_up_with_social, :edit_signed_up_with_social]

  COURSES_ON_CABINET_PAGE = 9

  def cabinet
    @my_courses = current_user.courses.page(params[:page]).per(COURSES_ON_CABINET_PAGE)
  end

  def signed_up_with_social
  end

  def edit_signed_up_with_social
    user = current_user

    if user.update(course_params)

      user.social_profiles.each do |social_profile|
        social_profile.update(signed_up_with_social: false)
      end
      sign_in :user, user, bypass: true

      redirect_to current_user
    else
      render :signed_up_with_social
      # Some error messages need to be placed here!
    end
  end
end
