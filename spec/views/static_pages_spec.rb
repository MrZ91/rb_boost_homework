require 'rails_helper'

describe 'Main page', type: :feature do
  subject { page }

  before { visit root_path }
  it { should have_title 'Rubyboost' }
  it { should have_link 'Courses', href: courses_path }
  it { should have_link 'Sign in!', href: new_user_session_path }
  it { should have_no_link 'Logout', href: destroy_user_session_path }
end
