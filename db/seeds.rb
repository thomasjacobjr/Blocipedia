require 'random_data'

# Create Wikis
50.times do
  Wiki.create!(
    title: Faker::Hipster.sentence,
    body: Faker::Hipster.paragraph
  )
end
wikis = Wiki.all

# Create Users
50.times do
  user = User.new(
    email: Faker::Internet.email,
    password: Faker::Internet.password(8)
  )
  user.skip_confirmation!
  user.save!
end
users = User.all

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
puts "#{Wiki.count} wikis created"
puts "#{User.count} users created"
puts "Standard user created (standard@test.com/ testtest)"
puts "Premium user created (premium@test.com/ testtest)"
puts "Admin user created (admin@test.com/ testest)"
