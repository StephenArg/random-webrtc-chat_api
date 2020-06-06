class ChangeConnectionsUserReferences < ActiveRecord::Migration[6.0]
  def change
    remove_column :connections, :user_id
    remove_column :connections, :other_user_id
    change_table(:connections) do |t|
      t.references :user, foreign_key: { to_table: 'users' }
      t.references :other_user, foreign_key: { to_table: 'users' }
    end
  end
end
