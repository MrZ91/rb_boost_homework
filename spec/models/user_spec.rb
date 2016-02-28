require 'rails_helper'

describe 'User', type: :model do
  let!(:user) do
    User.new(first_name: 'Example', last_name: 'User',
             email: 'example@mail.com', password: '123123',
             password_confirmation: '123123')
  end

  subject { user }

  it { should be_valid }

  context 'with first name' do
    context 'is empty' do
      before { user.first_name = '' }
      it { should_not be_valid }
    end

    context "that's contains unresolved symbols" do
      before { user.first_name = '1@/#/%/$_' }
      it { should_not be_valid }
    end
  end

  context 'with last name' do
    context 'is empty' do
      before { user.last_name = '' }
      it { should_not be_valid }
    end

    context "that's contains unresolved symbols" do
      before { user.last_name = '1@/#/%/$_' }
      it { should_not be_valid }
    end
  end

  context 'with email' do
    context "that's emtpy" do
      before { user.email = '' }
      it { should_not be_valid }
    end

    context 'form is invalid' do
      it 'should not be valid' do
        email_address = %w(qwe.qwe.qwe qwe@@qwe.qwe qwe@qwe @qwe.qwe)
        email_address.each do |ema|
          user.email = ema
          expect(user).not_to be_valid
        end
      end
    end

    context 'form is valid' do
      it 'should be valid' do
        email_address = %w(12_qwe@qwe.qwe QwE@qWe.qWe qwe.qwe-qwe@qwe.qwe)
        email_address.each do |ema|
          user.email = ema
          expect(user).to be_valid
        end
      end
    end

    context 'same as existing user' do
      before do
        existing_user = user.dup
        existing_user.email = user.email
        existing_user.save
      end
      it { should_not be_valid }
    end
  end

  context 'with password' do
    context 'that is emty' do
      before { user.password_confirmation = user.password = '' }
      it { should_not be_valid }
    end

    context 'that mismatch confirmation' do
      before { user.password_confirmation = user.password + '1' }
      it { should_not be_valid }
    end

    context "that's to short" do
      before { user.password_confirmation = user.password = '1234' }
      it { should_not be_valid }
    end

    context "that's contains unresolved symbols" do
      before { user.password = user.password_confirmation = '._-\!\@\#\$' }
      it { should_not be_valid }
    end

    context 'is too simple' do
      it 'should not be valid' do
        pass = %w(111111, 1111111, qqqqqq)
        pass.each do |pas|
          user.password = user.password_confirmation = pas
          expect(user).not_to be_valid
        end
      end
    end
  end
end
