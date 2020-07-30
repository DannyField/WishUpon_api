class MessageSerializer < ActiveModel::Serializer
  # Serializers will specifiy which data from the models will
  # get shared when broadcasting. Here when broadcasting
  # only the id, conversation_id, text and created at will
  # be sent
  attributes :id, :conversation_id, :text, :created_at
end

# Might be able to add user_id for the user who created the chat
# Currently chat is not working as it should.