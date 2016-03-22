FactoryGirl.define do
  factory :advancement do
    user
    lesson
    version { Faker::Lorem.paragraph(4) }
  end
end
