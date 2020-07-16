class Keyword < ApplicationRecord

    validates :word, presence: true;
    # belongs_to :wish
    # has_many :wish_keyword
    # has_many :wishes, through: :wish_keywords

end
