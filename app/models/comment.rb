class Comment < ApplicationRecord
  
  # Comments belong to a user and a wish. 
  belongs_to :user
  belongs_to :wish
  validates :content, presence: true, length: {in: 5..300}
end




