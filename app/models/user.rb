# All users of the platform will be a User object.
class User < ApplicationRecord
  # validation of User
  has_secure_password
  validates :email, presence: true, uniqueness: true
  validates :first_name, presence: true

  # Association of user, a user has many wishes
  # a user has many comments
  # a user has many hobbies
  # a user belongs to a country
  has_many :wishes
  has_many :comments
  has_many :user_hobbies, dependent: :destroy
  has_many :hobbies, through: :user_hobbies
  belongs_to :country

  attribute :age, :integer, default: 0
end
