class Collaboration < ActiveRecord::Base
  def self.users
    User.where( id: pluck(:user_id) )
  end

  def self.private_wikis
    Wiki.where( id: pluck(:wiki_id) )
  end

  def private_wiki
    Wiki.find(wiki_id)
  end

  def user
    User.find(user_id)
  end
end
