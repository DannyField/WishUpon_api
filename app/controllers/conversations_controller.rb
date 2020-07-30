class ConversationsController < ApplicationController
  # Finds all converstations and sends back json data
  # the front end.
  def index
    conversations = Conversation.all
    render json: conversations
  end

  # Creates a new room/converstation
  def create
    conversation = Conversation.new(conversation_params)
    # If the converstation is created and saved, then it will
    # broadcast the channel to the front end
    if conversation.save
      serialized_data = ActiveModelSerializers::Adapter::Json.new(
        ConversationSerializer.new(conversation)
      ).serializable_hash
      ActionCable.server.broadcast 'conversations_channel', serialized_data
      head :ok
    end
  end

  private

  # This passes through the title of the conversation / room.
  # A room must have a title
  def conversation_params
    params.require(:conversation).permit(:title)
  end
end
