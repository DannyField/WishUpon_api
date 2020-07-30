FactoryBot.define do
  factory :keyword do
        sequence :word do |n|
       "testkeyword#{n}" 
    end
  end
end
