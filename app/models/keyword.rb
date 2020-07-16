class Keyword < ApplicationRecord

    validates :word, presence: true, length: {in: 2..20}
    # belongs_to :wish
    # has_many :wish_keyword
    # has_many :wishes, through: :wish_keyword

end
