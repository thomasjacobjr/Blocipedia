require 'random_data'

# Create Wikis
#50.times do
#  Wiki.create!(
#    title: RandomData.random_sentence,
#    body: RandomData.random_paragraph
#  )
#end
#wikis = Wiki.all

50.times do
  user = User.new(
    email: RandomData.random_email,
    password: RandomData.random_word << RandomData.random_word << RandomData.random_word
  )
  user.skip_confirmation!
  user.save!
end
