class User < ApplicationRecord
  has_secure_password
  validates :email, presence: true, uniqueness: true
  validates :first_name, presence: true
  has_many :wishes
  has_many :comments
  has_many :user_hobbies, dependent: :destroy
  has_many :hobbies, through: :user_hobbies
  belongs_to :country
  attribute :age, :integer, default: 0
end
