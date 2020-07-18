class Wish < ApplicationRecord

    validates :title, presence: true, length: {in: 5..100}
    validates :description, presence: true, length: {in: 10..600}
    has_many :wish_keywords, dependent: :destroy
    has_many :keywords, through: :wish_keywords
    has_many :comments
    belongs_to :user

end
