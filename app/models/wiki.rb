class Wiki < ActiveRecord::Base
  belongs_to :user

  def collaborations
    Collaboration.where(wiki_id: self.id)
  end

  def users
    collaborations.users
  end
end
