require 'rails_helper'
require 'user/lessons_controller'
describe User::LessonsController, type: :controller do
  let(:user) { create :user }
  let!(:course) { create :course, user_id: user.id }

  before do
    user.add_role :trainer
    sign_in user
  end

  context 'create' do
    context 'with valid params' do
      it 'should create lesson' do
        expect do
          post :create, course_id: course.id, lesson: attributes_for(:lesson)
        end.to change(course.lessons, :count).by(1)
      end

      context 'should redirect to lesson page' do
        before { post :create, course_id: course.id, lesson: attributes_for(:lesson) }
        it { expect(response).to redirect_to user_course_lesson_path(course, course.lessons.last) }
      end
    end

    context 'with invalid params' do
      before { request.env['HTTP_REFERER'] = 'where_i_came_from' }
      it 'should not create lesson' do
        expect do
          post :create, course_id: course.id, lesson: attributes_for(:lesson, title: '')
        end.to change(course.lessons, :count).by(0)
      end

      context 'should redirect to new page' do
        before { post :create, course_id: course.id, lesson: attributes_for(:lesson, title: '') }
        it { expect(response).to render_template :new }
      end
    end
  end

  context 'show' do
    let(:lesson) { create :lesson, course_id: course.id }
    before { get :show, course_id: course.id, id: lesson.id }

    it 'should contain lesson' do
      expect(assigns(:lesson)).to eq(lesson)
    end

    it 'should render lesson page' do
      expect(response).to render_template(:show)
    end
  end
end
