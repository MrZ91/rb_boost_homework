FactoryGirl.define do
  factory :user do
    after(:create) do |user|
      create(:profile, user: user)
    end

    sequence(:email) { |i| "#{i}_example@mail.com" }
    password { '123456' }
    password_confirmation { '123456' }
  end

  factory :profile do
    association :user
    sequence(:first_name) { |i| "#{i}_Example" }
    sequence(:last_name) { |i| "#{i}_Name" }
  end
end
