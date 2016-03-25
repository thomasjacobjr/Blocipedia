class Wiki < ActiveRecord::Base
  belongs_to :user, polymorphic: true
  has_many :collaborations
  has_many :users, through: :collaborations, as: :collaborators

  def public?
    self.private == false
  end
end
