class AddBackConversationsUsersWithReferencesAgain < ActiveRecord::Migration[6.0]
  def change
    change_table(:conversations) do |t|
      t.references :user1
      t.references :user2
    end
    add_foreign_key :conversations, :users, column: :user1_id, primary_key: :id
    add_foreign_key :conversations, :users, column: :user2_id, primary_key: :id
  end
end
