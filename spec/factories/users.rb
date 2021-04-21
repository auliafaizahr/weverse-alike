FactoryBot.define do
  factory :user do
    email { Faker::Internet.email }
    password { "password" }
    username { Faker::Internet.user_name }
    name { Faker::Name.name }
    type_user { 1 }
  end
end
