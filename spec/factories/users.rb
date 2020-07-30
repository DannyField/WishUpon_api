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
    # country {"testcountry"}

    association :country
  end
end

def user_with_wish
  FactoryBot.create(:user) do|user|
    FactoryBot.create_list(:wish , 1 , user: user)
  end
end