FactoryGirl.define do
  factory :lesson do
    course
    sequence(:title) { |n| "Test lesson-#{n}" }
    description { Faker::Lorem.paragraph(4) }
    lecture_notes { Faker::Lorem.paragraph(4) }
    homework_text { Faker::Lorem.paragraph(4) }
  end
end
