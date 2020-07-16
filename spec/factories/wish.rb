FactoryBot.define do
  factory :wish do
    title {'Test wish'}
    description {'Test wish description'}
    is_anonymous {false}
    is_completed {false}
    is_matched {false}
  end
end