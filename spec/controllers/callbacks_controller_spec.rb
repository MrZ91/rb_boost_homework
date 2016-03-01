require 'rails_helper'
describe CoursesController, type: :controller do
  context 'user signed up wit social' do
    let!(:user) do
      user = User.new(email: "Test_with@social.login", password: 'notNullForPostgresql', password_confirmation: 'notNullForPostgresql',
                      profile_attributes: { first_name: 'Test', last_name: 'Test' })
      user.logged_with_social = true
      user.save!
      user
    end

    before do
      sign_in user
      get :index
    end

    it 'should configure profile first' do
      expect(response).to redirect_to(user_profile_signed_up_with_social_path)
    end
  end

  # context 'courses#index' do
  #   let!(:courses_ar) do
  #     courses = []
  #     3.times do
  #       courses.push(FactoryGirl.create(:course))
  #     end
  #     courses
  #   end
  #
  #   before do
  #     get :index
  #   end
  #
  #   it do
  #     expect(assigns(:courses)).to match_array courses_ar
  #   end
  # end
  #
  # context 'courses#show' do
  #   let!(:course) { create :course }
  #
  #   before do
  #     get :show, id: course.id
  #   end
  #
  #   it do
  #     expect(response).to render_template(:show)
  #     expect(assigns(:course)).to eq(course)
  #   end
  # end
end
