FactoryGirl.define do
  factory :user do
    role :user
    name { Faker::Name.name }
    email { Faker::Internet.email(name) }
    password "123456"
    password_confirmation { password }
  end
  
  factory :admin, parent: :user do
    role :admin
  end
end
