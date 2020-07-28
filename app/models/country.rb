class Country < ApplicationRecord
  # A country belongs to many users. ie Australia belongs to many users
  validates :name, presence: true
  has_many :users
end
