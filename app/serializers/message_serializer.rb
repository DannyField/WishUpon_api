class MessageSerializer < ActiveModel::Serializer
  attributes :id, :conversation_id, :text, :created_at
  # Might be able to add user_id for the user who created the chat
end
