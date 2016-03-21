class User < ActiveRecord::Base
  has_many :wikis
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable

  enum role: [:standard, :premium, :admin]

  def collaborations
    Collaboration.where(user_id: self.id)
  end

  def private_wikis
    Wiki.where( id: collaborations.pluck(:wiki_id) )
    # Wiki.where( id: collaborations.map{ |collaboration| collaboration.wiki_id }
  end

end
