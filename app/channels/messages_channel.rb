class MessagesChannel < ApplicationCable::Channel

  # Will broadcast new messages added to a specific conversation
  def subscribed
    # stream_from "some_channel"
    # Sends the messages to the converstaion/room channel
    conversation = Conversation.find(params[:conversation])
    # Expects an object from the model
    stream_for conversation
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
