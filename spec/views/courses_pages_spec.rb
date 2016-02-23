require 'rails_helper'
RSpec.describe 'Courses pages', type: feature do
  describe 'Show courses page as unsigned user' do
    subject { page }
    let!(:course) { create :course }

    before do
      visit courses_path
    end
    it { should have_title 'Rubyboost courses' }
    it { should have_link course.title, href: course_path(course) }
    it { should_not have_link 'Edit', href: edit_user_course_path(course, course.user) }
    it { should_not have_link 'delete', href: user_course_path(course, course.user) }
  end

  describe 'Show courses page as signed user' do
    let!(:another_course) { create :course }
    let!(:my_course) { create :course }

    before do
      login_as(my_course.user, scope: :user)
      visit courses_path
    end

    subject { page }

    # it do
    #   should have_no_link another_course.title,
    #                          user_course_path(another_course.user, another_course)
    # end

    it do
      should have_link my_course.title,
                       user_course_path(my_course.user, my_course)
    end
  end

  describe 'Show my courses in cabinet' do
    let!(:another_course) { create :course }
    let!(:my_course) { create :course }

    before do
      login_as(my_course.user, scope: :user)
      visit user_path(my_course.user)
    end

    subject { page }

    it do
      should_not have_link another_course.title,
                           user_course_path(another_course.user, another_course)
    end

    it do
      should_not have_link another_course.title,
                           course_path(another_course)
    end

    it do
      should have_link my_course.title,
                       user_course_path(my_course.user, my_course)
    end
  end

  describe 'Create course page' do
    let!(:user) { create :user }

    before do
      login_as(user, scope: :user)
      visit new_user_course_path(user)
    end

    subject { page }

    it { should have_title 'Rubyboost Create your own course' }

    context 'with invalid information' do
      before do
        fill_in 'Title', with: ''
        fill_in 'Description', with: ''
      end
      it { expect { click_button 'Create Course' }.not_to change(Course, :count) }
    end

    context 'with valid information' do
      before do
        fill_in 'Title', with: 'Course test-title'
        fill_in 'Description', with: Faker::Lorem.paragraph(3)
      end
      it { expect { click_button 'Create Course' }.to change(Course, :count) }
    end
  end

  describe 'Edit course page' do
    let!(:course) { create :course }
    let(:upd_btn) { 'Update Course' }

    subject { page }

    before do
      login_as(course.user, scope: :user)
      visit root_path
    end

    context 'from index page' do
      before do
        click_link('Show courses')
        click_link(course.title)
        click_link('Edit')
      end

      it { should have_title 'Rubyboost Edit course' }

      context 'should have correct information' do
        it { should have_content course.description }
      end

      context 'with' do
        context 'invalid title' do
          before do
            fill_in 'Title', with: ''
            click_button upd_btn
          end
          it { should have_content("can't be blank") }
        end

        context 'invalid description' do
          before do
            fill_in 'Description', with: ''
            click_button upd_btn
          end
          it { should have_content("can't be blank") }
        end
      end

      context 'should change information' do
        let(:new_title) { 'New test-title' }
        let(:new_description) { Faker::Lorem.paragraph(3) }
        before do
          fill_in 'Title', with: new_title
          fill_in 'Description', with: new_description
          click_button upd_btn
        end
        specify { expect(course.reload.title).to eq new_title }
        specify { expect(course.reload.description).to eq new_description }
      end
    end

    context 'from cabinet page' do
      before do
        click_link('My cabinet')
        click_link(course.title)
        click_link('Edit')
      end

      it { should have_title 'Rubyboost Edit course' }

      context 'should have correct information' do
        it { should have_content course.description }
      end

      context 'with' do
        context 'invalid title' do
          before do
            fill_in 'Title', with: ''
            click_button upd_btn
          end
          it { should have_content("can't be blank") }
        end

        context 'invalid description' do
          before do
            fill_in 'Description', with: ''
            click_button upd_btn
          end
          it { should have_content("can't be blank") }
        end
      end

      context 'should change information' do
        let(:new_title) { 'New test-title' }
        let(:new_description) { Faker::Lorem.paragraph(3) }
        before do
          fill_in 'Title', with: new_title
          fill_in 'Description', with: new_description
          click_button upd_btn
        end
        specify { expect(course.reload.title).to eq new_title }
        specify { expect(course.reload.description).to eq new_description }
      end
    end
  end
end
