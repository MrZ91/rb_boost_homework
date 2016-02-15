require 'rails_helper'
describe 'Show courses page' do
  subject {page}
  let(:course){Course.create(title:'Course test-title', description: Faker::Lorem.paragraph(1))}
  before do
    visit courses_path
  end
  it {should have_title 'Rubyboost courses'}
  it {should have_link 'Edit', href:edit_course_path(course)}
  it {should have_link 'delete', href:course_path(course) }
end

describe 'Create course page' do

  before{visit new_course_path}

  subject{page}

  it {should have_title 'Rubyboost Create your own course'}

  describe 'with invalid information' do
    before do
      fill_in 'Title', with: ''
      fill_in 'Description', with: ''
    end
    it {expect {click_button 'Create Course'}.not_to change(Course, :count)}
  end

  describe 'with valid information' do
    before do
      fill_in 'Title', with: 'Course test-title'
      fill_in 'Description', with: Faker::Lorem.paragraph(3)
    end
    it {expect {click_button 'Create Course'}.to change(Course, :count)}
  end
end

describe 'Edit course page' do
  let(:course){Course.create(title:'Course test-title', description: Faker::Lorem.paragraph(1))}
  let(:upd_btn){'Update Course'}

  subject{page}

  before do
    visit edit_course_path(course)
  end

  it {should have_title 'Rubyboost Edit course'}

  #It is seen while debugging page.html .
  describe 'should have correct information' do
    it do
      #binding.pry
      should have_content course.title
    end
    it {should have_content course.description}
  end

  describe 'with'do
    describe 'invalid title' do
      before do
        fill_in 'Title', with:''
        click_button upd_btn
      end
         it {should have_content("can't be blank")}
    end
    describe 'invalid description' do
      before do
        fill_in 'Description', with:''
        click_button upd_btn
      end
      it {should have_content("can't be blank")}
    end
  end

  describe 'should change information' do
    let(:new_title){'New test-title'}
    let(:new_description){Faker::Lorem.paragraph(3)}
    before do
      fill_in 'Title', with:new_title
      fill_in 'Description', with:new_description
      click_button upd_btn
    end
    specify { expect(course.reload.title).to  eq new_title }
    specify { expect(course.reload.description).to eq new_description }
  end
end