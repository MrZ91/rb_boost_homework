FactoryGirl.define do
  factory :course do
    user

    sequence(:title)  { |n| "Test course-#{n}" }
    description { 'Test description' }
  end
end
