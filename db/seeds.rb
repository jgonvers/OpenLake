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

Lorem_user = "Hello everybody, I'm looking forward to doing sports with you all! I am available every day, whole day long (currently unemployed). Feel free to T-Mate me!"
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
  last_name: "McSim",
  content: "My name is Maxime, I'm a Scottish student currently working on a thesis whose topic is the Influence of Western Litterature on Post-Modern Industrialism. I'm also a sports-lover and I love eating cupcakes.",
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
  content: "Hi guys <3 My name is Kilian, but everybody calls me Kiki. I come from Québec and I hate when people make fun of my accent. I came to Switzerland to study nuclear physics. I love pedalos and dancing. My favourite band is ABBA.",
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

puts "create 5 past events by kilian"
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

puts "create 5 future events by kilian"
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

n = -20
puts "create 50 other events with 5 attendants"
15.times do
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


n = 10
puts "create 50 other events with 5 attendants"
25.times do
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

puts "add up to 10 T-Mates to kilian@email.com"
10.times do
  u2 = us
  while u2 == us || u2 == us2
    u2 = user.sample
  end
  teammate_create(us, u2)
  puts "."
end

puts "add up to 20 T-Mates to maxime@email.com"
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



puts "create 1 specific event by kilian"
1.times do
  u = us2
  date = Time.new(2021,04,10,10,00)
  e = Event.new(
    title: "".titleize,
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

# [[title, address, category], ...]
event_array = [
  ["tour de lavaux", "Route de Claie-aux-Moines 5, 1073 Savigny", "biking"],
  ["foot 5v5", "Chemin des Tuilières, 1028 Préverenges", "football"],
  ["jogging chill", "Avenue d'Echallens 109, 1004 Lausanne", "running"],
  ["bowling tournament", "Chemin du Tennis 3, 1026 Echandens", "bowling"],
  ["beach volley 3v3", "Avenue de la Plage 23, 1028 Préverenges", "volleyball"],
  ["Winter swimming", "Village 180, 2406 La Brévine", "swimming"],
  ["early-birds jogging", "Route du Signal 2, 1018 Lausanne", "running"],
  ["drunken football", "Route des Plaines-du-Loup 7, 1018 Lausanne", "football"],
  ["10v10 Foot", "Avenue de Vertou 6, 1110 Morges", "football"],
  ["5KM Practice", "Route des Arsenaux 9, 1700 Fribourg", "running"],
  ["Tour De Vidy", "Avenue Gustave Doret, 1007 Lausanne", "biking"],
  ["6v6 volleyball", "Rue des Corps-Saints 20, 1201 Genève", "volleyball"],
  ["Hardcore Swim", "Place du Château 1, 1860 Aigle", "swimming"],
  ["Competitive Bowling", "Allée Ferdi Kübler 12, 1860 Aigle", "bowling"],
  ["Bowling With Friends", "Chemin de Bethléem, 1700 Fribourg", "bowling"],
  ["Downhill  Mountain Bike", "Stalden 7-1, 1700 Fribourg", "biking"],
  ["Wild Soccer Game", "Chemin du Pré-Cartelier 8-18, 1202 Genève", "football"],
  ["Morning Swim", "Chemin des Mines 11, 1202 Genève", "swimming"],
  ["Marathon Prep Run", "Rue J.-de-Hochberg 23-21, 2000 Neuchâtel", "running"],
  ["Bike Til U Die", "Rue des Corps-Saints 20, 1201 Genève", "biking"],
  ["7v7 Foot", "Route des Arsenaux 9, 1700 Fribourg", "football"],
  ["Amateur Bowling", "Avenue Gustave Doret, 1007 Lausanne", "bowling"],
  ["Volley Tournament", "Cité de l'Ouest 1, 2000 Neuchâtel", "volleyball"],
  ["Bowling Competition", "Chemin du Petit-Pontarlier 7A, 2000 Neuchâtel", "bowling"],
  ["Tour du Léman", "Avenue Nestlé, 1800 Vevey", "biking"],
  ["No Rules Soccer", "Rue du Midi, 1800 Vevey", "football"],
  ["Race Against Ducks", "Rue de l'Eglise Catholique 8, 1820 Montreux", "swimming"],
  ["Slow-Paced 10K", "Rue de la Gare 33-29, 1820 Montreux", "running"],
  ["Hot Beach-Volley", "Avenue de Belmont, 1820 Montreux", "volleyball"],
  ["16km Practice", "Route des Arsenaux 9, 1700 Fribourg", "running"],
]


puts "create specific events"
n = 2
event_array.each do |event|
  u = us
  while u == us || u == us2
    u = user.sample
  end
  date = date_generator(n)
  e = Event.new(
    title: event[0].titleize,
    address: event[1],
    creator: u,
    content: Lorem_event,
    category: Category.where(name: event[2])[0],
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
  n+=1
end
