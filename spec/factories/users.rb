
FactoryGirl.define do
  factory :user do

    email { Faker::Internet.email }
    password "password"
    password_confirmation "password"
    confirmed_at Date.today
    name { Faker::Name.name }
    role 0
  end
end
