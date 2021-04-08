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

Image_extension = [".jpg", ".png", ".jpeg", ".JPG"]

Address_list = address

Lorem_user = "Hello everybody, I'm looking forward to doing sports with you all! I am available every day after 6 pm. Feel free to T-Mate me!"
Lorem_event = "Little warm-up event, nothing too crazy, feel free to join and let's have fun!"
avatars_m = Dir.entries(Avatar_folder_m).select { |file| Image_extension.include? File.extname(file) }
avatars_f = Dir.entries(Avatar_folder_f).select { |file| Image_extension.include? File.extname(file) }

def date_generator(jour_decalage)
  now = Time.now
  hour = (14...18).to_a.sample
  min = [0, 15, 30, 45].sample
  date = Time.new(now.year, now.month, now.day, hour, min)
  date += jour_decalage * 24*60*60
end

def create_male(image_list)
  fname = Faker::Name.male_first_name
  lname = Faker::Name.last_name
  un = User.new(
    first_name: fname,
    last_name: lname,
    content: Lorem_user,
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
    content: Lorem_user,
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

puts "create 1 user maxime@email.com"
u = User.new(
  first_name: "Maxime",
  last_name: "Jost",
  content: "My name is Maxime, I am lonely and have no friends. That's probably because my shower hasn't been working in 5 years. I hope this app will allow me to meet nice people.",
  password: '1234567',
  password_confirmation: '1234567',
  email: "maxime@email.com",
  address: "chemin de montolivet 35, 1006 Lausanne"
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

puts "create users"
until avatars_m.count.zero? && avatars_f.count.zero?
  unless avatars_m.count.zero?
    create_male(avatars_m)
    puts "."
  end

  unless avatars_f.count.zero?
    create_female(avatars_f)
    puts "."
  end
end


puts "create 1 user kilian@email.com"
u = User.new(
  first_name: "Kilian",
  last_name: "Hayat",
  content: "Hi guys <3 My name is Kilian, but everybody calls me Kiki. I come from Québec and I hate when people make fun of my accent. I came to Switzerland to study nuclear physics. I love biking, running and dancing. My favourite band is ABBA.",
  password: '1234567',
  password_confirmation: '1234567',
  email: "kilian@email.com",
  address: "Moudon"
  )
u.save!
file = File.open("./app/assets/images/seed/user/image (1).png")
u.photo.attach(io: file, filename: "avatar-#{u.id}.jpg", content_type: 'image/jpg')

user = User.all
date = Time.now - 10 * 3600 * 24
us = User.first
us2 = u
categories = Category.all

puts "create 5 event by kilian past"
n=-6
5.times do
  c = categories.sample
  u = us2
  date = date_generator(n)
  e = Event.new(
    title: "#{Faker::Adjective.positive} #{c.name.downcase}".titleize,
    address: Address_list.sample,
    creator: u,
    content: Lorem_event,
    category: c,
    start_time: date,
    end_time: date + [1, 2].sample * 3600,
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

puts "create 5 event by kilian future"
n=3
5.times do
  c = categories.sample
  u = us2
  date = date_generator(n)
  e = Event.new(
    title: "#{Faker::Adjective.positive} #{c.name.downcase}".titleize,
    address: Address_list.sample,
    creator: u,
    content: Lorem_event,
    category: c,
    start_time: date,
    end_time: date + [1, 2].sample * 3600,
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

n = -10
puts "create 50 other event with 5 attendant"
50.times do
  c = categories.sample
  u = us
  while u == us || u == us2
    u = user.sample
  end
  date = date_generator(n)
  e = Event.new(
    title: "#{Faker::Adjective.positive} #{c.name.downcase}".titleize,
    address: Address_list.sample,
    creator: u,
    content: Lorem_event,
    category: c,
    start_time: date,
    end_time: date + [1, 2].sample * 3600,
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

puts "add up to 10 teammates to kilian@email.com"
10.times do 
  u2 = us
  while u2 == us || u2 == us2
    u2 = user.sample
  end
  teammate_create(us, u2)
  puts "."
end

puts "add up to 20 teammates to maxime@email.com"
20.times do 
  u2 = us
  while u2 == us || u2 == us2
    u2 = user.sample
  end
  teammate_create(us2, u2)
  puts "."
end

puts "create 50 teammates links"
50.times do
  u = us
  while u == us || u == us2
    u = user.sample
  end
  u2 = u
  while u2 == u || u2 == us2 || u2 == us
    u2 = user.sample
  end
  teammate_create(u, u2)
  puts "."
end



puts "create 1 specific event by maxime"
1.times do
  u = us2
  date = Time.new(2021,04,10,10,00)
  e = Event.new(
    title: "agonizing Swimming".titleize,
    address: "Place de la Navigation 3, 1006 Lausanne",
    creator: u,
    content: "I'm organizing a little swimming session in the lake, it will be hard, no casual swimmers accepted ;) Then we can all grab a bite for lunch.",
    category: Category.where(name:"swimming")[0],
    start_time: date,
    end_time: date + [1, 2].sample * 3600,
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

  3.times do
    u2 = us
    while u2 == us || u2 == us2 
      u2 = us.teammates.sample
    end
    if u2 != u && !(e.users.include? u2)
      Attendance.new(
        user: u2,
        event: e
      ).save!
    end
  end
  puts "."
end
