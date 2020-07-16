FactoryBot.define do
  factory :user do
    email { "MyString" }
    password_digest { "MyString" }
    first_name { "" }
    last_name { "" }
    nickname { "" }
    age { 1 }
    is_admin { false }
    gender { 1 }
  end
end
