class Wish < ApplicationRecord

    validates :title, presence: true, length: {in: 5..100}
    validates :description, presence: true, length: {in: 10..600}
    # belongs_to :user

end
