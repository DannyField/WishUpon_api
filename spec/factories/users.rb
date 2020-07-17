FactoryBot.define do
  factory :user do
    sequence :email do |n|
       "testuser#{n}@test.com" 
    end
    password { "password123" }
    first_name { "" }
    last_name { "" }
    nickname { "" }
    age { 1 }
    is_admin { false }
    gender { 1 }

    association :country
  end
end
