class AddBackConversationsUserIdsWithReferences < ActiveRecord::Migration[6.0]
  def change
    change_table(:conversations) do |t|
      t.references :user1, foreign_key: { to_table: 'users' }
      t.references :user2, foreign_key: { to_table: 'users' }
    end
  end
end
