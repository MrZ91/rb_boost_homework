require 'rails_helper'

describe 'Main page', type: :feature do
  subject {page}

  before{visit root_path}
  it {should have_title 'Rubyboost'}
  it {should have_link 'Show courses', href:courses_path}
  it {should have_link 'Create your own course', href:new_course_path}
end
