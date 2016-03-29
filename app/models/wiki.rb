class Wiki < ActiveRecord::Base
  belongs_to :user, polymorphic: true
  has_many :collaborations
  has_many :collaborators, through: :collaborations, source: :user 

  def public?
    self.private == false
  end
end
