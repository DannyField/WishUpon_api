class Message < ApplicationRecord
  # A message belongs to a conversation/room
  belongs_to :conversation
end
