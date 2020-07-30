class ConversationsChannel < ApplicationCable::Channel
  
  # This is used to broadcast newly created conversations
  def subscribed
    # stream_from "some_channel"
    # Expects to recieve a string as an argument 
    stream_from "conversations_channel"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
