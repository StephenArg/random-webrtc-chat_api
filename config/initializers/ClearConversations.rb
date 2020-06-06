begin
  if Conversation
    Conversation.destroy_all
  end
rescue
  puts "No Conversation Class Yet"
end