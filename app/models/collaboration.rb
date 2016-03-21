class Collaboration < ActiveRecord::Base
  belongs_to :user
  belongs_to :private_wiki 
end
