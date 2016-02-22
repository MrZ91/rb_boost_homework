FactoryGirl.define do
  factory :user do
    first_name {'Example'}
    last_name {'User'}
    email    { 'example@mail.com' }
    password { '123456' }
    password_confirmation { '123456' }
  end
end
