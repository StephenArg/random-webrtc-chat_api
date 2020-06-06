class CreateConversations < ActiveRecord::Migration[6.0]
  def change
    create_table :conversations do |t|
      t.integer :user_id
      t.integer :other_user_id
      t.string :status

      t.timestamps
    end
  end
end
