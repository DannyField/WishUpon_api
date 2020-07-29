class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :wish
  validates :content, presence: true, length: { in: 5..300 }
end
