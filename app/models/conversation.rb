class Conversation < ApplicationRecord
  # has_one :user, :class_name => User, :foreign_key => :user1_id
  # has_one :user, :class_name => User, :foreign_key => :user2_id
  belongs_to :user1, :class_name => 'User', optional: true
  belongs_to :user2, :class_name => 'User', optional: true
end
