require 'rails_helper'
RSpec.describe 'Courses pages', type: feature do
  let(:show_courses_lnk) { 'Courses' }
  let(:sign_in_link) { 'Sign in!' }
  let(:sign_in_btn) { 'Log in' }

  describe 'Create course page' do
    let!(:user) { create :user }

    before do
      visit root_path
      click_link sign_in_link
      fill_in 'Email', with: user.email
      fill_in 'Password', with: '123456'
      click_button sign_in_btn
      click_link 'Create course'
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
      visit root_path
      click_link sign_in_link
      fill_in 'Email', with: course.user.email
      fill_in 'Password', with: '123456'
      click_button sign_in_btn
    end

    context 'from cabinet page' do
      before do
        click_link 'Cabinet'
        click_link course.title
        click_link 'Edit'
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
