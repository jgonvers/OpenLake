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
  content: "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s",
  password: '1234567',
  password_confirmation: '1234567',
  email: "user@email.com",
  address: "chemin de montolivet 35, 1006 Lausanne"
  )
u.save!

puts "create a category"
c = Category.new(
  name: "volleyball"
)
c.save!



puts "create an event"
date = Time.now
e = Event.new(
  title:"Foot outdoor 5 vs 5",
  address: "Morges",
  creator: u,
  content: 'Contrary to popular belief, Lorem Ipsum is not simply random text. It has roots in a piece of classical Latin literature from 45 BC, making it over 2000 years old.',
  category: c,
  start_time: date,
  end_time: date + 3600,
  participants_maximum: 20
)
e.save!


puts "create 10 user"
10.times do
  un = User.new(
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    content: 'It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters, as opposed to using Content here, content here, making it look like readable English.',
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

