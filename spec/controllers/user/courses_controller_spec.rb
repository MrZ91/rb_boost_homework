require 'rails_helper'
require 'user/courses_controller'
describe User::CoursesController, type: :controller do
  let!(:user) { create :user }
  before { sign_in user }

  context 'create' do
    context 'with valid params' do
      it 'should create course' do
        expect { post :create, course: attributes_for(:course) }.to change(user.courses, :count).by(1)
      end

      context 'should redirect to creation' do
        before { post :create, course: attributes_for(:course, title: '') }
        it { expect(response).to render_template :new }
      end
    end

    context 'with invalid params' do
      it 'should create course' do
        expect { post :create, course: attributes_for(:course, title: '') }.to change(user.courses, :count).by(0)
      end

      context 'should redirect to course page' do
        before { post :create, course: attributes_for(:course) }
        it { expect(response).to redirect_to user_course_path(user.courses.last) }
      end
    end
  end

  context 'show' do
    let(:course) { create :course, user_id: user.id }
    before { get :show, id: course.id }

    it 'should contain course' do
      expect(assigns(:course)).to eq(course)
    end

    it 'should render course page' do
      expect(response).to render_template(:show)
    end
  end

  context 'update' do
    let(:attributes) { attributes_for :course }
    let(:course) { create :course, user_id: user.id }

    context 'with valid params' do
      before do
        attributes[:title] = 'Changed title'
        attributes[:description] = 'Changed description'
        patch :update, id: course.id, course: attributes
      end
      it 'should change course params' do
        expect(user.courses.where(id: course.id).first.title).to eq('Changed title')
        expect(user.courses.where(id: course.id).first.description).to eq('Changed description')
      end

      context 'should redirect to course page' do
        it { expect(response).to redirect_to user_course_path(course) }
      end
    end

    context 'with invalid params' do
      before do
        @old_title = attributes[:title]
        attributes[:title] = ''
        patch :update, id: course.id, course: attributes
      end
      it 'should not to change course params' do
        expect do
          user.courses.where(id: course.id).first.title.to_not eq('')
          user.courses.where(id: course.id).first.title.to eq(@old_title)
        end
      end

      context 'should redirect to edit course page' do
        it { expect(response).to render_template(:edit) }
      end
    end
  end
end
