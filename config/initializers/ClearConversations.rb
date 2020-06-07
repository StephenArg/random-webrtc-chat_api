begin
  if Conversation
    puts "Clearing all Conversations"
    Conversation.destroy_all
  end
rescue
  puts "No Conversation Class Yet"
end