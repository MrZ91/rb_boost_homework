FactoryGirl.define do
  factory :course do
    user
    sequence(:title) { |n| "Test course-#{n}" }
    description { Faker::Lorem.paragraph(4) }
  end
end
