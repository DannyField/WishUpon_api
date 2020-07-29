# A comment belongs to a user, and also belongs to a wish
# A comment is only valid with valid content, ranging from 5 to 300 characters.
class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :wish
  validates :content, presence: true, length: { in: 5..300 }
end
