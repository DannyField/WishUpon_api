class Keyword < ApplicationRecord
  # Validation of keyword
  # Keyword word attribute need to be unique
  validates :word, presence: true, length: { in: 2..20 }, uniqueness: true
  has_many :wish_keywords, dependent: :destroy
  has_many :wishes, through: :wish_keywords
end
