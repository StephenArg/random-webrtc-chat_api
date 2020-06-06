class User < ApplicationRecord
  has_many :connections
  has_many :other_users, through: :connections
  has_many :conversations1, class_name: "Conversation", foreign_key: "user1_id"
  has_many :conversations2, class_name: "Conversation", foreign_key: "user2_id"

  has_many :inverse_connections, class_name: "Connection", foreign_key: :other_user_id
  has_many :inverse_other_users, through: :inverse_connections, source: :user

  validates :email, uniqueness: {:case_sensitive => false}
  has_secure_password

  def all_users
    all_users = []
    all_users.push(self.other_users)
    all_users.push(self.inverse_other_users)
    puts all_users
    all_users.flatten!.uniq!
  end

  def all_connections
    all_connections = []
    all_connections.push(self.connections)
    all_connections.push(self.inverse_connections)
    puts all_connections
    all_connections.flatten!
  end


end
