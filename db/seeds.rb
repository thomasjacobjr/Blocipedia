require 'random_data'

N_WIKIS = 50
N_USERS = 50

# Create some wikis.
N_WIKIS.times do
 Wiki.create!(
   title: RandomData.random_sentence,
   body: RandomData.random_paragraph
 )
end
puts "#{N_WIKIS} additional wikis created."

# Create some users.
N_USERS.times do
  user = User.new(
    email: RandomData.random_email,
    password: RandomData.random_word << RandomData.random_word << RandomData.random_word
  )
  user.skip_confirmation!
  user.save!
end
puts "#{N_USERS} additional users created."

