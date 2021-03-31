# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)



def teammate_create(user1, user2)
  if TeammateLink.where(user:user1, teammate:user2).count.zero?
    TeammateLink.new(user:user1, teammate:user2).save!
    TeammateLink.new(user:user2, teammate:user1).save!
  end
end


Avatar_folder_m = "./app/assets/images/seed/user/male/"
Avatar_folder_f = "./app/assets/images/seed/user/female/"

Image_extension = [".jpg", ".png", ".jpeg"]

Address_list = ["Lausanne", "Morges", "Renens", "Montreux", "Moudon", "Genève"]

Lorem = "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."

Avatars_m = Dir.entries(Avatar_folder_m).select { |file| Image_extension.include? File.extname(file) }
Avatars_f = Dir.entries(Avatar_folder_f).select { |file| Image_extension.include? File.extname(file) }

def create_male
  fname = Faker::Name.male_first_name
  lname = Faker::Name.last_name
  un = User.new(
    first_name: fname,
    last_name: lname,
    content: Lorem,
    password: '1234567',
    password_confirmation: '1234567',
    email: "#{fname.downcase}.#{lname.downcase}@email.com",
    address: Address_list.sample
  )
  un.save!
  file = File.open(Avatar_folder_m + Avatars_m.sample)
  un.photo.attach(io: file, filename: "avatar-#{un.id}.jpg", content_type: 'image/jpg')
end

def create_female
  fname = Faker::Name.female_first_name
  lname = Faker::Name.last_name
  un = User.new(
    first_name: fname,
    last_name: lname,
    content: Lorem,
    password: '1234567',
    password_confirmation: '1234567',
    email: "#{fname.downcase}.#{lname.downcase}@email.com",
    address: Address_list.sample
  )
  un.save!
  file = File.open(Avatar_folder_f + Avatars_f.sample)
  un.photo.attach(io: file, filename: "avatar-#{un.id}.jpg", content_type: 'image/jpg')
end

  category = {
    bowling: 'fa-bowling-ball',
    biking: 'fa-biking',
    football: 'fa-futbol',
    running: 'fa-running',
    swimming: 'fa-swimmer',
    volleyball: 'fa-volleyball-ball'
  }

puts "create 1 user user@email.com"
u = User.new(
  first_name: Faker::Name.male_first_name,
  last_name: Faker::Name.last_name,
  content: Lorem,
  password: '1234567',
  password_confirmation: '1234567',
  email: "user@email.com",
  address: "chemin de montolivet 35, 1006 Lausanne"
  )
u.save!
file = File.open(Avatar_folder_m + Avatars_m.sample)
u.photo.attach(io: file, filename: "avatar-#{u.id}.jpg", content_type: 'image/jpg')


puts "create categories"
category.each do |cat, val|
  Category.new(
    name: cat.to_s,
    logo_link: val
  ).save!
end

puts "create 20 user"
20.times do
  if ["f","m"].sample == "f"
    create_female
  else
    create_male
  end
  puts "."
end

puts "create an event for user@email.com"
u = User.first
date = Time.now
e = Event.new(
  title:"Foot outdoor 5 vs 5",
  address: "Morges",
  creator: u,
  content: Lorem,
  category: Category.where(name:"football").first,
  start_time: date,
  end_time: date + 3600,
  participants_maximum: 20
)
e.save!

puts "add 10 attendant to event"
10.times do
  u2 = User.all.sample
  if u2 != u && !(e.users.include? u2)
    Attendance.new(
      user: u2,
      event: e
    ).save!
  end
  puts "."
end


puts "create 50 other event with 5 attendant"
n=1
50.times do
  c = Category.all.sample
  u = User.all.sample
  e = Event.new(
    title: "#{Faker::Adjective.positive} #{c.name.downcase}",
    address: Address_list.sample,
    creator: u,
    content: Lorem,
    category: c,
    start_time: date + n*60*60*24,
    end_time: date + 3600 + n*60*60*24,
    participants_maximum: 20
  )
  e.save!
  5.times do
    u2 = User.all.sample
    if u2 != u && !(e.users.include? u2)
      Attendance.new(
        user: u2,
        event: e
      ).save!
    end
  end
  puts "."
end

puts "add up to 10 teammates to user@email.com"
u = User.first
10.times do 
  u2 = User.all.sample
  teammate_create(u, u2)
  puts "."
end

puts "create 50 teammates links"
50.times do
  u = User.all.sample
  u2 = u
  while u == u2
    u2 = User.all.sample
  end
  teammate_create(u, u2)
  puts "."
end

puts "add 1 event par category to the second user with 5 attendant"

u = User.second

Category.all.each do |c|
  e = Event.new(
    title: "#{Faker::Adjective.positive} #{c.name.downcase}",
    address: Address_list.sample,
    creator: u,
    content: Lorem,
    category: c,
    start_time: date + n*60*60*24,
    end_time: date + 3600 + n*60*60*24,
    participants_maximum: 20
  )
  e.save!
  5.times do
    u2 = User.all.sample
    if u2 != u && !(e.users.include? u2)
      Attendance.new(
        user: u2,
        event: e
      ).save!
    end
  end
  puts "."
end