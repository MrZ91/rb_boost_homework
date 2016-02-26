require 'rails_helper'
describe CoursesController, type: :controller do
  context 'courses#index' do
    let!(:courses_ar) do
      courses = []
      3.times do
        courses.push(FactoryGirl.create(:course))
      end
      courses
    end

    before do
      get :index
    end

    it do
      expect(assigns(:courses)).to match_array courses_ar
    end
  end

  context 'courses#show' do
    let!(:course) { create :course }

    before do
      get :show, id: course.id
    end

    it do
      expect(response).to render_template(:show)
      expect(assigns(:course)).to eq(course)
    end
  end
end
