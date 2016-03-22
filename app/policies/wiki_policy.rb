class WikiPolicy < ApplicationPolicy
  class Scope < Scope

    def resolve
      if user.role == 'admin'
        return scope.all
      elsif user.role == 'premium'
        all_wikis = scope.all
        all_wikis.each do |wiki|
          if wiki.public? || wiki.owner == user || wiki.collaborators.include?(user)
            wikis << wiki
          end
        end
      else
        all_wikis = scope.all
        wikis = []
        all_wikis.each do |wiki|
          if wiki.public? || wiki.collaborators.include?(user)
            wikis << wiki
          end
        end
      end
      wikis
    end
  end

  def update?
    user.admin? || user.premium?
  end
end
