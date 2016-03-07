require 'rails_helper'
describe CoursesController, type: :controller do
  context 'courses#index' do
    let!(:user) { create(:user) }
    let!(:courses_ar) do
      courses = []
      3.times do
        courses.push(FactoryGirl.create(:course, user_id: user.id))
      end
      courses
    end

    before do
      get :index
    end

    it 'should contain all courses' do
      expect(assigns(:courses)).to match_array courses_ar
    end

    context do
      before do
        courses_ar.last.toggle(:visible).save!
        courses_ar.delete(courses_ar.last)
      end

      it 'should show only visible courses' do
        expect(assigns(:courses)).to match_array courses_ar
      end
    end
  end

  context 'courses#show' do
    let!(:user) { create(:user) }
    let!(:course) { create :course, user_id: user.id }
    let!(:users_ar) do
      users = []
      3.times do
        user = create(:user)
        users.push user
        course.subscribers << user
      end
      users
    end

    before do
      get :show, id: course.id
    end

    it 'should render template' do
      expect(response).to render_template(:show)
    end

    it 'should contain course' do
      expect(assigns(:course)).to eq(course)
    end

    it 'should contain subscribers' do
      expect(assigns(:subscribers)).to match_array users_ar
    end
  end
end
