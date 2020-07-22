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

def wish_with_comments
  FactoryBot.create(:wish) do|wish|
    FactoryBot.create_list(:comment , 2 , wish: wish)
  end
end