class WikiPolicy < ApplicationPolicy
  def update?
    user.admin? || user.premium? 
  end
end
