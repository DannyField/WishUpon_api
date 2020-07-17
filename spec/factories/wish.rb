FactoryBot.define do
  factory :wish do
    sequence :title do |n|
      "Factory Test Wish no.#{n}"
    end
    description {'Test wish description'}
    is_anonymous {false}
    is_completed {false}
    is_matched {false}

    association :user

    trait :invalid do
      title {nil}
    end
  end
end