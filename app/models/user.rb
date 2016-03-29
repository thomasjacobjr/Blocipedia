class User < ActiveRecord::Base
  has_many :wikis
  has_many :collaborations, through: :wikis
  has_many :private_wikis, through: :collaborations, source: :wiki 
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable

  enum role: [:standard, :premium, :admin]
end
