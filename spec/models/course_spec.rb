require 'rails_helper'

describe 'Course model' do
  before do
    @course = Course.new(title:'Course test-title', description: Faker::Lorem.paragraph(3))
  end

  subject {@course}

  it {should respond_to :title}
  it {should respond_to :description}
  it {should be_valid}

  describe 'with empty title' do
    before {@course.title=''}
    it {should_not be_valid}
  end

  describe 'with empty description' do
    before {@course.description=''}
    it {should_not be_valid}
  end

  describe 'with empty title and description' do
    before do
      @course.title=''
      @course.description=''
    end
    it {should_not be_valid}
  end
end
