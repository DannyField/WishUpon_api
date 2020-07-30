FactoryBot.define do
  factory :user do
    sequence :email do |n|
       "testuser#{n}@test.com" 
    end
    password { "password123" }
    first_name { "testfirstname" }
    last_name { "testlastname" }
    nickname { "nickname" }
    age { 1 }
    is_admin { false }
    gender { 1 }

    association :country
  end
end
