class Keyword < ApplicationRecord
    validates :word, presence: true, length: {in: 2..20}
    has_many :wish_keywords
    has_many :wishes, through: :wish_keywords

end
