require 'rails_helper'

describe 'Lesson', type: :model do
  let!(:course) { create :course }
  let(:lessons_arr) { course.lessons.pluck(:position) }

  context 'Lessons are created by ascending position' do
    before { create_list(:lesson, 3, course_id: course.id) }
    it { expect(lessons_arr).to match_array((1..3).to_a) }
  end

  context 'Lessons after removal of changing positions correctly' do
    before do
      create_list(:lesson, 4, course_id: course.id)
      course.lessons.where(position: 3).first.destroy
    end
    it { expect(lessons_arr).to match_array((1..3).to_a) }
  end
end
