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

  def renegotiation_offer_to_user
    @other_user_id = find_other_user_id()
    if @other_user_id
      ActionCable.server.broadcast "conversation_channel_user_id:#{@other_user_id}",
                                   {action: "incoming_renegotiation_offer",
                                    offer: data['payload']['offer']}
    end
  end

  def renegotiation_answer_to_user
    @other_user_id = find_other_user_id()
    if @other_user_id
      ActionCable.server.broadcast "conversation_channel_user_id:#{@other_user_id}",
                                   {action: "incoming_renegotiation_answer",
                                    answer: data['payload']['answer']}
    end
  end

  def candidate(data)
    @other_user_id = find_other_user_id()
    if @other_user_id
      ActionCable.server.broadcast "conversation_channel_user_id:#{@other_user_id}",
                                   {action: "incoming_candidate", candidate: data['payload']['candidate']}
    end
  end

  def message(data)
    @other_user_id = find_other_user_id()
    if @other_user_id
      ActionCable.server.broadcast "conversation_channel_user_id:#{@other_user_id}",
                                   {action: "incoming_message", message: data['payload']['message']}
    end
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
    @conversation = Conversation.find(params["conversation_id"])
    if @conversation.user1_id == nil or @conversation.user2_id == nil
      puts "user1_id", @conversation.user1_id, "user2_id", @conversation.user2_id
      @conversation.destroy
    else
      @other_user_id = find_other_user_id()
      ActionCable.server.broadcast "conversation_channel_user_id:#{@other_user_id}",
                                    {action: 'reopen_conversation'}
    end
  end

  private

  def find_other_user_id
    # It's kinda useless to stream from the conversation object, as I need to find the other user each time anyway.
    # I may as well send that to the user to use from then on as data to send back to the back end.
    @conversation = Conversation.find(params['conversation_id'])
    return @conversation.user1_id == params['id'] ? @conversation.user2_id : @conversation.user1_id
  end

end
