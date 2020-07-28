# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

country1 = Country.create(name:"Australia")
country2 = Country.create(name:"China")
puts "Countries are created"

user1 = User.create(
        email: "admin@wishupon.com",
        password: "password",
        first_name: 'Adam',
        last_name: 'Admin',
        nickname: 'The Admin',
        age: 100,
        is_admin: true,
        gender: 0,
        country_id: 1
      )

user2 = User.create(
        email: "user1@wishupon.com",
        password: "password",
        first_name: 'Ming',
        last_name: 'Zhu',
        nickname: 'user1',
        age: 20,
        is_admin: false,
        gender: 0,
        country_id: 2
      )
puts "user created"


wish1 = Wish.create(
        title: "I want to win Lotto",
        description: "Need to pay off the mafia for my gambling debt. So please let me win Lotto",
        is_secret: false,
        is_anonymous: false,
        is_completed: false,
        is_matched: false,
        like: 0,
        expiry_time: nil,
        user_id: 1
      )

wish2 = Wish.create(
        title: "I want score 7 in IELTS exam",
        description: "I want score 7 in IELTS exam this year",
        is_secret: false,
        is_anonymous: false,
        is_completed: false,
        is_matched: false,
        like: 0,
        expiry_time: nil,
        user_id: 2
      )

wish3 = Wish.create(
        title: "Looking for someone to go rock climbing with",
        description: "I want to go rock climbing but none of my friends want to go...I want to learn from experienced rock climbers in Melbourne.",
        is_secret: false,
        is_anonymous: false,
        is_completed: false,
        is_matched: false,
        like: 0,
        expiry_time: nil,
        user_id: 2
      )

wish4 = Wish.create(
        title: "Would love to see the cherry blossoms in Japan",
        description: "I want to travel to Japan but due to lockdown the travel plan is postponed. But I still hope to see the beautiful scenary of cherry blossoms.",
        is_secret: false,
        is_anonymous: false,
        is_completed: true,
        is_matched: false,
        like: 0,
        expiry_time: nil,
        user_id: 2
      )

puts "wishes created!"

hobby1 = Hobby.create(name:"fishing")
hobby2 = Hobby.create(name:"painting")
puts "Hobbies are created"

keyword1 = Keyword.create(word:"friend")
keyword2 = Keyword.create(word:"travel")
keyword3 = Keyword.create(word:"japan")

keyword4 = Keyword.create(word:"english")
keyword5 = Keyword.create(word:"study")
keyword6 = Keyword.create(word:"exam")


keyword7 = Keyword.create(word:"money")
keyword8 = Keyword.create(word:"Lotto")
puts "Keywords are created"

WishKeyword.create(wish_id:4, keyword_id:1)
WishKeyword.create(wish_id:4, keyword_id:2)
WishKeyword.create(wish_id:4, keyword_id:3)
WishKeyword.create(wish_id:1, keyword_id:7)
WishKeyword.create(wish_id:1, keyword_id:8)
WishKeyword.create(wish_id:2, keyword_id:4)
WishKeyword.create(wish_id:2, keyword_id:5)
WishKeyword.create(wish_id:2, keyword_id:6)
puts "WishKeyword relationship are created"

UserHobby.create(user_id: 1, hobby_id:2)
UserHobby.create(user_id: 2, hobby_id:1)
puts "UserHobby relationship are created"

Comment.create(content:"I liked your wish.",user_id:2,wish_id:1)
Comment.create(content:"Good luck!",user_id:1,wish_id:2)
puts "Comments are created"

puts "creating a chat room"
Conversation.create(title: 'Admin private room')
puts 'created a private room'

puts "Adding a message to our chat room: Room 1"
Message.create(text: "Welcome to our private room where we can chat", conversation_id: 1)
puts 'A comment / message has been added to Room 1'