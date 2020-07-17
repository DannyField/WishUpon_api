# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

puts "Creating a user role"

1.times do 
    u = User.create(
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
puts "#{u.email} : was added to users"
end

puts "Creating new wishes"

1.times do
    w = Wish.create(
        title: "I want to win Lotto",
        description: "Need to pay off the mafia for my gambling debt. So please let me win Lotto",
        is_secret: false,
        is_anonymous: false,
        is_completed: false,
        is_matched: false,
        like: 4,
        expiry_time: nil,
        user_id: 1
    )
puts "#{w.title} : wish completed!"
end

country1 = Country.create(name:"Australia")
country2 = Country.create(name:"China")
puts "Countries are created"

hobby1 = Hobby.create(name:"fishing")
hobby2 = Hobby.create(name:"painting")
puts "Hobbies are created"

keyword1 = Keyword.create(word:"friend")
keyword2 = Keyword.create(word:"travel")
keyword3 = Keyword.create(word:"japan")
puts "Keywords are created"

WishKeyword.create(wish_id:1, keyword_id:1)
WishKeyword.create(wish_id:1, keyword_id:2)
WishKeyword.create(wish_id:1, keyword_id:3)
puts "WishKeyword relationship are created"

UserHobby.create(user_id: 1, hobby_id:2)
puts "UserHobby relationship are created"