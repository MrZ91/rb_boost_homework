require 'rails_helper'
RSpec.describe 'Courses pages', type: feature do
  describe 'Courses page' do
    context 'as unsigned user' do
      before { visit courses_path }
      it { expect(page).to have_title 'Rubyboost courses' }
    end

    context 'as unsigned user' do
      let!(:user) { FactoryGirl.create(:user) }
      before do
        login_as(user, scope: :user)
        visit courses_path
      end
      it { expect(page).to have_title 'Rubyboost courses' }
    end
  end
end
