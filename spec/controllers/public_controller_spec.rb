require 'rails_helper'

describe CoursesController, type: :controller do
  describe 'courses#index' do

    let!(:course1) {create :course}
    let!(:course2) {create :course}
    let!(:course3) {create :course}
    let!(:course4) {create :course}
    let!(:course5) {create :course}
    let!(:course6) {create :course}

    before do
      get :index
    end

    it {expect(assigns(:courses)).to match_array [course1, course2, course3, course4, course5]}
    it {expect(assigns(:courses)).to_not include course6}
  end
end
