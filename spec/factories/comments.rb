FactoryBot.define do
  factory :comment do
    sequence :content do |n|
       "Test Comment#{n}" 
    end

    trait :invalid do
      content {nil}
    end

      association :user
      association :wish

  end
end
