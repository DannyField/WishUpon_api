class MessagesController < ApplicationController
  # creates a new message
  def create
    message = Message.new(message_params)
    # Finds the conversation_id (room) 
    conversation = Conversation.find(message_params[:conversation_id])
    # if new message and saved, then broadcast
    if message.save
      serialized_data = ActiveModelSerializers::Adapter::Json.new(
        MessageSerializer.new(message)
      ).serializable_hash
      MessagesChannel.broadcast_to conversation, serialized_data
      head :ok
    end
  end

  private

  # Passes the conversation_id and the text from the Message
  def message_params
    params.require(:message).permit(:text, :conversation_id)
  end
  end
