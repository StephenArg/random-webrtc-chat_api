class RemoveConversationsUsersAgain < ActiveRecord::Migration[6.0]
  def change
    remove_column :conversations, :user1_id
    remove_column :conversations, :user2_id
  end
end
