class WikiPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      if user.premium? || user.admin?
        scope.all
      else
        scope.where(["private = ?", false])
      end
    end
  end

  def update?
    user.admin? || user.premium?
  end
end
