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
        password_digest: "password",
        first_name: 'Adam',
        last_name: 'Admin',
        nickname: 'The Admin',
        age: 100,
        is_admin: true,
        gender: 0,
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
    )
puts "#{w.title} : wish completed!"
end

