FactoryGirl.define do
  factory :lesson do
    course
    sequence(:title) { |n| "Test lesson-#{n}" }
    description { Faker::Lorem.paragraph(4) }
    lecture_notes { Faker::Lorem.paragraph(4) }
    homework_text { Faker::Lorem.paragraph(4) }
    date_of { Faker::Date.between(DateTime.now.days_since(1), DateTime.now.months_since(5)) }
  end
end
