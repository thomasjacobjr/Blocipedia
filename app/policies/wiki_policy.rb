class WikiPolicy < ApplicationPolicy
  class Scope < Scope

    #TODO -- room for refactoring - we don't want to call entire collection every time!
    
    def resolve
      if user.role == 'admin'
        return scope.all

      elsif user.role == 'premium'
        all_wikis = scope.all
        wikis = []
        all_wikis.each do |wiki|
          if wiki.public? || wiki.user == user || wiki.collaborations.include?(user)
            wikis << wiki
          end
        end

      else
        all_wikis = scope.all
        wikis = []
        all_wikis.each do |wiki|
          if wiki.public? || wiki.collaborations.include?(user)
            wikis << wiki.id
          end
        end
      end

      wikis
      Wiki.where(id: wikis)

    end
  end

  def update?
    user.admin? || user.premium?
  end
end
