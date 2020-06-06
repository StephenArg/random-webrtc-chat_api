class ConversationChannel < ApplicationCable::Channel
  def subscribed
    # stream_from "some_channel"
    @conversation = Conversation.find(params['conversation_id'])
    stream_from "conversation_channel_user:#{params['id']}"
    stream_for @conversation
  end

  def printParams(stuff)
    @conversation = Conversation.find(params['conversation_id'])
    @other_user_id = @conversation.user1_id == params['id'] ? @conversation.user2_id : @conversation.user1_id
    puts "sending_to:" + "conversation_channel_user:#{@other_user_id}"
    if @other_user_id
      ActionCable.server.broadcast "conversation_channel_user:#{@other_user_id}", { cool: "nice!" }
    end
    # ConversationChannel.broadcast_to(current_user, stuff: "what")
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
    @conversation = Conversation.find(params["conversation_id"])
    if @conversation.user1_id == nil or @conversation.user2_id == nil
      @conversation.destroy
    else
      ConversationChannel.broadcast_to(@conversation, {send_id: true})
    end
  end
end
