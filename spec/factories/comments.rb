FactoryBot.define do
  factory :comment do
    content { "Test comment" }

    
    trait :invalid do
      title {nil}
    end

      association :user
      association :wish

  end
end
