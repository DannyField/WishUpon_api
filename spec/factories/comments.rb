FactoryBot.define do
  factory :comment do
    content { "Test comment" }
      association :user
      association :wish

  end
end
