class User < ApplicationRecord

    has_secure_password
    validates :email, presence: true, uniqueness: true
    has_many :wishes
    has_many :comments
    has_many :user_hobbies
    has_many :hobbies, through: :user_hobbies
    belongs_to :country

end
