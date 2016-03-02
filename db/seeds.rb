require 'random_data'

N_WIKIS = 50
N_USERS = 50

# Create Wikis
N_WIKIS.times do
  Wiki.create!(
    title: Faker::Hipster.sentence,
    body: Faker::Hipster.paragraph
  )
end

# Create Users
N_USERS.times do
  user = User.new(
    email: Faker::Internet.email,
    password: Faker::Internet.password(8)
  )
  user.skip_confirmation!
  user.save!
end

# Create a default user
user1 = User.new(email: "standard@test.com", password: "testtest", role: 0)
user1.skip_confirmation!
user1.save

user2 = User.new(email: "premium@test.com", password: "testtest", role: 1)
user2.skip_confirmation!
user2.save

user3 = User.new(email: "admin@test.com", password: "testtest", role: 2)
user3.skip_confirmation!
user3.save



puts "Seed finished"
puts "#{N_WIKIS} additional wikis created"
puts "#{N_USERS} additional users created"
puts "Standard user created (standard@test.com/ testtest)"
puts "Premium user created (premium@test.com/ testtest)"
puts "Admin user created (admin@test.com/ testest)"
