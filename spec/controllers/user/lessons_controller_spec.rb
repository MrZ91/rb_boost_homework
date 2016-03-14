require 'rails_helper'
require 'user/lessons_controller'
describe User::LessonsController, type: :controller do
  let(:user) { create :user }
  let!(:course) { create :course, user_id: user.id }
  before { sign_in user }

  context 'create' do
    context 'with valid params' do
      it 'should create course' do
        expect do
          post :create, course_id: course.id, lesson: attributes_for(:lesson)
        end.to change(course.lessons, :count).by(1)
      end

      context 'should redirect to course page' do
        before { post :create, course_id: course.id, lesson: attributes_for(:lesson) }
        it { expect(response).to redirect_to user_course_path(course, anchor: 'homework') }
      end
    end

    context 'with invalid params' do
      it 'should create course' do
        expect do
          post :create, course_id: course.id, lesson: attributes_for(:lesson, title: '')
        end.to change(course.lessons, :count).by(0)
      end

      context 'should redirect to course page' do
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
