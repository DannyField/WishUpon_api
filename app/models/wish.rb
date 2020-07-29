# Base model of the web app platform, can be created by users.
class Wish < ApplicationRecord
  # validateion of Wish
  # Wish is not valid without these attributes.
  validates :title, presence: true, length: { in: 5..100 }
  validates :description, presence: true, length: { in: 10..600 }

  # Association of wish
  # wish belongs to a user
  belongs_to :user

  # wish has many keywords through wish_keywords join table
  # wish has many comments
  has_many :wish_keywords, dependent: :destroy
  has_many :keywords, through: :wish_keywords
  has_many :comments, dependent: :destroy

  has_one_attached :image
  attribute :is_completed, :boolean, default: false
  attribute :like, :integer, default: 0
end
