# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)



def teammate_create(user1, user2)
  if TeammateLink.where(user:user1, teammate:user2).count.zero?
    TeammateLink.new(user:user1, teammate:user2, status: "accepted").save!
    TeammateLink.new(user:user2, teammate:user1, status: "accepted").save!
  end
end

address = []
File.foreach("./db/address.txt") { |line| address << line.strip }

Avatar_folder_m = "./app/assets/images/seed/user/male/"
Avatar_folder_f = "./app/assets/images/seed/user/female/"

Image_extension = [".jpg", ".png", ".jpeg"]

Address_list = address

Lorem = "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."

avatars_m = Dir.entries(Avatar_folder_m).select { |file| Image_extension.include? File.extname(file) }
avatars_f = Dir.entries(Avatar_folder_f).select { |file| Image_extension.include? File.extname(file) }

def create_male(image_list)
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
  image = image_list.sample
  image_list.delete(image)
  file = File.open(Avatar_folder_m + image)
  un.photo.attach(io: file, filename: "avatar-#{un.id}.jpg", content_type: 'image/jpg')
end

def create_female(image_list)
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
  image = image_list.sample
  image_list.delete(image)
  file = File.open(Avatar_folder_f + image)
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

puts "create 1 user camilla@email.com"
u = User.new(
  first_name: "Camilla",
  last_name: Faker::Name.last_name,
  content: "My name is Camilla, I used to live in the UK but after my divorce with Charles I have decided to come and live in Switzerland where noone knows me. I like knitting and horse-riding, and I would like to meet new people. I don't speak french very well, so if a cute guy wants to teach me, I am open to anything ;)",
  password: '1234567',
  password_confirmation: '1234567',
  email: "camilla@email.com",
  address: "chemin de montolivet 35, 1006 Lausanne"
  )
u.save!
file = File.open("./app/assets/images/seed/user/image (1).png")
u.photo.attach(io: file, filename: "avatar-#{u.id}.jpg", content_type: 'image/jpg')


puts "create 1 user maxime@email.com"
u = User.new(
  first_name: "Maxime",
  last_name: "Jost",
  content: "My name is Maxime, I am lonely and have no friends. That's probably because my shower hasn't been working in 5 years. I hope this app will allow me to meet nice people.",
  password: '1234567',
  password_confirmation: '1234567',
  email: "maxime@email.com",
  address: "Moudon"
  )
u.save!
file = File.open("./app/assets/images/seed/user/image.png")
u.photo.attach(io: file, filename: "avatar-#{u.id}.jpg", content_type: 'image/jpg')

puts "create categories"
category.each do |cat, val|
  Category.new(
    name: cat.to_s,
    logo_link: val
  ).save!
end

puts "create male user"
until avatars_m.count.zero?
  create_male(avatars_m)
  puts "."
end

puts "create female user"
until avatars_f.count.zero?
  create_female(avatars_f)
  puts "."
end


user = User.all
date = Time.now - 10 * 3600 * 24
us = User.first
us2 = User.second
categories = Category.all

puts "create 5 event by maxime"
n=1
5.times do
  c = categories.sample
  u = us2
  e = Event.new(
    title: "#{Faker::Adjective.positive} #{c.name.downcase}".titleize,
    address: Address_list.sample,
    creator: u,
    content: Lorem,
    category: c,
    start_time: date + n*60*60*24 - [1, 0].sample * 3600,
    end_time: date + n*60*60*24 + [1, 2].sample * 3600,
    participants_maximum: (5..25).to_a.sample
  )
  e.save!
  5.times do
    u2 = us
    while u2 == us || u2 == us2 
      u2 = user.sample
    end
    if u2 != u && !(e.users.include? u2)
      Attendance.new(
        user: u2,
        event: e
      ).save!
    end
  end
  n += 1
  puts "."
end

puts "create 50 other event with 5 attendant"
50.times do
  c = categories.sample
  u = us
  while u == us
    u = user.sample
  end
  e = Event.new(
    title: "#{Faker::Adjective.positive} #{c.name.downcase}".titleize,
    address: Address_list.sample,
    creator: u,
    content: Lorem,
    category: c,
    start_time: date + n*60*60*24 - [1, 0].sample * 3600,
    end_time: date + n*60*60*24 + [1, 2].sample * 3600,
    participants_maximum: (5..25).to_a.sample
  )
  e.save!
  5.times do
    u2 = user.sample
    if u2 != u && !(e.users.include? u2)
      Attendance.new(
        user: u2,
        event: e
      ).save!
    end
  end
  n += 1
  puts "."
end

puts "add up to 3 teammates to user@email.com"
3.times do 
  u2 = us
  while u2 == us
    u2 = user.sample
  end
  teammate_create(us, u2)
  puts "."
end

puts "create 25 teammates links"
25.times do
  u = us
  while u == us
    u = user.sample
  end
  u2 = u
  while u == u2 || u2 == us
    u2 = user.sample
  end
  teammate_create(u, u2)
  puts "."
end
