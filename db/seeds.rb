# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


puts "create 1 user user@email.com"

u = User.new(
  first_name: Faker::Name.first_name,
  last_name: Faker::Name.last_name,
  password: '1234567',
  password_confirmation: '1234567',
  email: "user@email.com",
  address: "Lausanne"
  )
u.save!

puts "create a category"
c = Category.new(
  name: "test category"
)
c.save!

puts "create an event"
e = Event.new(
  title:"test event",
  address: "Lausanne",
  creator: u,
  category: c,
  participants_maximum: 200
)
e.save!


puts "create 10 user"
10.times do
  un = User.new(
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    password: '1234567',
    password_confirmation: '1234567',
    email: Faker::Internet.email,
    address: "Lausanne"
  )
  un.save!
  Attendance.new(
    event:e,
    user:un
  ).save!
end

