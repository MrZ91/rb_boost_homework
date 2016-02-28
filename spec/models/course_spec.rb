require 'rails_helper'

describe Course, type: :model do
  before do
    @course = Course.new(title: 'Course test-title',
                         description: Faker::Lorem.paragraph(3))
  end

  subject { @course }

  it { should validate_presence_of :title }
  it { should validate_presence_of :description }
  it { should validate_length_of(:title).is_at_most(50) }
  it { should be_valid }

  describe 'with empty title' do
    before { @course.title = '' }
    it { should_not be_valid }
  end

  describe 'with empty description' do
    before { @course.description = '' }
    it { should_not be_valid }
  end

  describe 'with empty title and description' do
    before do
      @course.title = ''
      @course.description = ''
    end
    it { should_not be_valid }
  end
end
