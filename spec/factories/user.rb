FactoryGirl.define do
  factory :user do
    profile_attributes { FactoryGirl.attributes_for(:profile) }
    sequence(:email) do |i|
      email = ''
      email << profile_attributes[:first_name]
      email << "_#{i}_"
      email << profile_attributes[:last_name]
      Faker::Internet.safe_email(email)
    end
    password { '123456' }
    password_confirmation { '123456' }
  end
end
