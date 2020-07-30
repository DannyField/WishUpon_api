class MessagesChannel < ApplicationCable::Channel
  def subscribed
    # stream_from "some_channel"
    # Sends the messages to the converstaion/room channel
    conversation = Conversation.find(params[:conversation])
    stream_for conversation
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
