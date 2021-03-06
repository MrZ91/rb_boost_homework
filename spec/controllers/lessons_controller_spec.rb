require 'rails_helper'
describe LessonsController, type: :controller do
  let!(:user) { create(:user) }
  let!(:course) { create(:course, user_id: user.id) }
  let!(:lesson) { create(:lesson, course_id: course.id) }

  context 'show' do
    before do
      sign_in user
      course.subscribers << user
      get :show, id: lesson.id, course_id: course.id
    end

    it 'should render template' do
      expect(response).to render_template(:show)
    end

    it 'should contain lesson' do
      expect(assigns(:lesson)).to eq lesson
    end
  end
end
