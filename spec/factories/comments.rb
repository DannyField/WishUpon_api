FactoryBot.define do
  factory :comment do
    content { "Test comment" }

    trait :invalid do
      content {nil}
    end

      association :user
      association :wish

  end
end
