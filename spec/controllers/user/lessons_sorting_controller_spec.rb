require 'rails_helper'
describe User::LessonsSortingController, type: :controller do
  let(:user) { create :user }
  let(:course) { create :course, user_id: user.id }

  before do
    course.lessons << create_list(:lesson, 5)
    user.add_role :trainer
    sign_in user
  end

  context 'sort' do
    let(:order) do
      old_order = course.lessons.pluck(:id)
      [old_order[3], old_order[1], old_order[2], old_order[4], old_order[0]]
    end

    before { get :sort, id: course.id, 'homework-list' => order }

    it { expect(course.lessons.pluck(:id)).to match_array order }
  end
end
