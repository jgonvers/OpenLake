# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


address_list = ["Lausanne", "Morges", "Renens", "Montreux", "Moudon", "Genève"]

lorem = "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."


puts "create 1 user user@email.com"

u = User.new(
  first_name: Faker::Name.first_name,
  last_name: Faker::Name.last_name,
  content: lorem
  password: '1234567',
  password_confirmation: '1234567',
  email: "user@email.com",
  address: address_list.sample
  )
u.save!

category = {
  Bowling: '<i class="fas fa-bowling-ball" style="color: #ce4e4e; font-size: 15px;"></i>',
  Biking: '<i class="fas fa-biking" style="color: #32b53b; font-size: 15px;"></i>',
  Football: '<i class="fas fa-futbol" style="color: #735BBF; font-size: 15px;"></i>',
  Running: '<i class="fas fa-running" style="color: orange; font-size: 15px;"></i>',
  Swimming: '<i class="fas fa-swimmer" style="color: #59cdea; font-size: 15px;"></i>',
  Volleyball: '<i class="fas fa-volleyball-ball" style="color: #FFD700; font-size: 15px;"></i>'
}


puts "create categories"
category.each do |cat, val|
  Category.new(
    name: cat.to_s,
    logo_link: val
  ).save!
end

puts "create 20 user"
10.times do
  fname = Faker::Name.first_name
  lname = Faker::Name.last_name
  un = User.new(
    first_name: fname,
    last_name: lname,
    content: lorem,
    password: '1234567',
    password_confirmation: '1234567',
    email: "#{fname.downcase}.#{lname.downcase}@email.com"
    address: address_list.sample
  )
end

puts "create an event for user@email.com"
date = Time.now
e = Event.new(
  title:"Foot outdoor 5 vs 5",
  address: "Lausanne",
  creator: u,
  content: lorem,
  category: category.where(name:"Footbal").first,
  start_time: date,
  end_time: date + 3600,
  participants_maximum: 20
)
e.save!

puts "add 10 attendant to event"
10.times do
  u2 = User.all.sample
  if u2 != u
    Attendance.new(
      user: u2,
      event: e
    )
  end
end