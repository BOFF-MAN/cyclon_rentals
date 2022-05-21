# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'faker'

puts "Running seed file"
# Seed 5 users
puts "Seeding 4 users..."

david = User.new(name: "David Bradford", email: "david.bradford@gmail.com", password: 123456, bio: "After qualifying as a Chartered Accountant at Deloitte, I moved into the tech startup world working in the finance team of a few companies. I am currently Head of Finance at Coadjute - a blockchain based network for the UK property market.
  I've always had an interest in tech and love geeking out on Excel writing long formulas. I would like to learn more about coding and learn to build my own web apps to indulge my interest.
  One day I want to launch my own business and this course will help set me on that path.")
david.save
david.avatar.attach(io: File.open(Rails.root.join("app/assets/images/avatar-db.jpeg")), filename: "avatar-db.jpeg")

yuval = User.new(name: "Yuval Zoref", email: "yuval.zoref@gmail.com", password: 123456, bio: "I come from a background in theatre and i am now looking to learn a new skill for a potential career change in the near future!")
yuval.save
yuval.avatar.attach(io: File.open(Rails.root.join("app/assets/images/avatar-yz.jpeg")), filename: "avatar-yz.jpeg")

sean = User.new(name: "Sean Buckle", email: "sean.buckle@gmail.com", password: 123456, bio: "I worked in TV and Film before moving to Computer repair and support. I want to learn to code to get more fulfilment from my employment and hopefully change my lifestyle as a result.")
sean.save
sean.avatar.attach(io: File.open(Rails.root.join("app/assets/images/avatar-jc.jpeg")), filename: "avatar-jc.jpeg")

jonno = User.new(name: "Jonno Clifford", email: "jonno.clifford@gmail.com", password: 123456, bio: "I'm Australian raised but London based for the last 10 years. I currently work as a commercial photographer and videographer, and previously worked in graphic and (basic) web design. I'm doing the bootcamp to build a complimentary skill set which may lead to a full career change, or possibly just some new approaches to current projects I work on. I'm really excited to get cracking and meet everyone!")
jonno.save
jonno.avatar.attach(io: File.open(Rails.root.join("app/assets/images/avatar-jc.jpeg")), filename: "avatar-jc.jpeg")

# Seed 20 bikes
puts "Seeding 20 bikes..."

RATES = [5,10,15,20,25,30]
USERS = [1,2,3,4]
CATEGORIES = ['Road Bike', 'Mountain Bike', 'Commuter Bike']
DESCRIPTIONS = ["12 Speed bike. Easy to ride. Requires cleats. Only ridden about 200km in total.",
  "My all time favourite bike. Travelling for business and looking for a long term renter to look after it",
  "Old but gold. Single speed but glides along the road.",
  "After riding this for a few days you will want one yourself. Open to offers to buy permanently",
  "Full spec tour bike. Comfort seat customised. New coat of paint."
]

ADDRESSES = [
  "6 Werter Rd, London SW15 2LJ",
  "93 Lower Richmond Rd., London SW15 1EU",
  "41 Jews Row, London SW18 1TB",
  "Peterborough Rd, London SW6 3ED",
  "19 Michael Rd, London SW6 2ER",
  "Richmond Way, London W14 0AX",
  "Beaumont St, Oxford OX1 2PH",
  "140 Cowley Rd, Oxford OX4 1JJ",
  "John Garne Way, Headington, Oxford OX3 0FP",
  "Bardwell Rd, Oxford OX2 6ST",
  "Trumpington St, Cambridge CB2 1RB",
  "Church Rd, Cambridge CB25 9AF",
  "15-18 Viking Way, Bar Hill, Cambridge CB23 8EL",
  "Cambridge Rd, Milton, Cambridge CB24 6AZ",
  "Leisure Park, Clifton Way, Cambridge CB1 7DY",
  "13 Bond St, Brighton BN1 1RD",
  "Marshalls Row, Brighton BN1 4JU",
  "Florence Rd, Brighton BN1 6DL",
  "Freshfield Rd, Brighton BN2 9XZ",
  "Lewes Rd, Brighton BN2 3QA"
]

n = 0
20.times do
  bike = Bike.new(
    name: Faker::Superhero.name,
    description: DESCRIPTIONS.sample,
    daily_rate: RATES.sample,
    category: CATEGORIES.sample,
    user_id: USERS.sample,
    address: ADDRESSES[n]
  )
  bike.save
  bike.photo.attach(io: File.open(Rails.root.join("app/assets/images/bike-pic-#{n+1}.jpg")), filename: "bike-pic-#{n+1}.jpg")
  puts "Bike #{n+1} seeded"
  n += 1
end

puts "Seed Complete!"
