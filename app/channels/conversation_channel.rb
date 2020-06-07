class ConversationChannel < ApplicationCable::Channel
  def subscribed
    # stream_from "some_channel"
    @conversation = Conversation.find(params['conversation_id'])
    stream_from "conversation_channel_user_id:#{params['id']}"
    stream_for @conversation
  end

  def printParams(stuff)
    @other_user_id = find_other_user_id()
    if @other_user_id
      ActionCable.server.broadcast "conversation_channel_user_id:#{@other_user_id}", {cool: "what"}
    end
    # ConversationChannel.broadcast_to @conversation, {what: "this sends to both users"}
  end

  def offer_to_user(data)
    @other_user_id = find_other_user_id()
    if @other_user_id
      ActionCable.server.broadcast "conversation_channel_user_id:#{@other_user_id}",
                                   {action: "incoming_offer",
                                    offer: data['payload']['offer'],
                                    otherUsersLocation: data['payload']['otherUsersLocation'],
                                    otherUsersName: data['payload']['otherUsersName']}
    end
  end

  def answer_to_user(data)
    @other_user_id = find_other_user_id()
    if @other_user_id
      ActionCable.server.broadcast "conversation_channel_user_id:#{@other_user_id}",
                                   {action: "incoming_answer",
                                    answer: data['payload']['answer'],
                                    otherUsersLocation: data['payload']['otherUsersLocation'],
                                    otherUsersName: data['payload']['otherUsersName']}
    end
  end

  def candidate(data)
    @other_user_id = find_other_user_id()
    if @other_user_id
      ActionCable.server.broadcast "conversation_channel_user_id:#{@other_user_id}",
                                   {action: "incoming_candidate", candidate: data['payload']['candidate']}
    end
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

  private

  def find_other_user_id
    @conversation = Conversation.find(params['conversation_id'])
    return @conversation.user1_id == params['id'] ? @conversation.user2_id : @conversation.user1_id
  end

end
