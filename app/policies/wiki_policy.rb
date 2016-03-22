class WikiPolicy < ApplicationPolicy
  class Scope < Scope

    def resolve
      if user.role == 'admin'
        return scope.all
      elsif user.role == 'premium'
        tbl = scope.arel_table
        return scope.where(tbl[:private].eq(false).or(tbl[:user_id].eq(user.id)))

#        return scope.where(user: user)

#        all_wikis = scope.all
#        wikis = []
#        all_wikis.each do |wiki|
#          if wiki.public? || wiki.user == user || wiki.collaborations.include?(user)
#            wikis << wiki
#          end
#        end
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
