class RemoveConversationsUserIds < ActiveRecord::Migration[6.0]
  def change
    remove_column :conversations, :user_id
    remove_column :conversations, :other_user_id
  end
end
