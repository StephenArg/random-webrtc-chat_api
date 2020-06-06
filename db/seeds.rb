# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


user1 = User.create(name: "Steve", email:"steve@what.com", password: 'what1' )
user2 = User.create(name: "Bob", email:"bob@what.com", password: 'what1' )
user3 = User.create(name: "Sarah", email: "sarah@what.com", password: 'what1')

Conversation.create(user_id: user1.id, other_user_id: user2.id, status: 'closed')
Connection.create(user_id: user1.id, other_user_id: user2.id)

Conversation.create(user_id: user3.id, other_user_id: user2.id, status: 'closed')
Connection.create(user_id: user3.id, other_user_id: user2.id)

Conversation.create(user_id: user2.id, other_user_id: user1.id, status: 'closed')
Connection.create(user_id: user2.id, other_user_id: user1.id)



