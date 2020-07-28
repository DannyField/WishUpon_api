class Conversation < ApplicationRecord
    # A conversation has many messages. 
    has_many :messages
end
