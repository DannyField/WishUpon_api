FactoryBot.define do
  factory :country do
        sequence :name do |n|
       "testcountry#{n}" 
    end
  end
end
