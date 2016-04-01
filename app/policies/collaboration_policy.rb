class CollaborationPolicy < ApplicationPolicy

  def destroy?
    user.admin? || record.wiki.user == user
    #FIXME || user = record.user 
  end

end
