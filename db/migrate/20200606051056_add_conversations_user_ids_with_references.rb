class AddConversationsUserIdsWithReferences < ActiveRecord::Migration[6.0]
  def change
    change_table(:conversations) do |t|
      t.references :user, foreign_key: { to_table: 'users' }
      t.references :other_user, foreign_key: { to_table: 'users' }
    end
  end
end
