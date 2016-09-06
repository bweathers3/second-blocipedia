
class WikiPolicy < ApplicationPolicy

    def scope
      Pundit.policy_scope!(user, record.class)
    end

  class Scope
   attr_reader :user, :scope

   def initialize(user, scope)
     @user = user
     @scope = scope
   end

   def resolve
     wikis = []
     if user.role == 'admin'
       wikis = scope.all # if the user is an admin, show them all the wikis
     elsif user.role == 'premium'
       p user.role
       all_wikis = scope.all
       all_wikis.each do |wiki|
         p wiki
         if wiki.private? || #wiki.user == user || #wiki.collaborators.include?(user)
           wikis << wiki # if the user is premium, only show them public wikis, or that private wikis they created, or private wikis they are a collaborator on
         end
       end
     else # this is the lowly standard user
       all_wikis = scope.all
       wikis = []
       all_wikis.each do |wiki|
         if wiki.private? || #wiki.collaborators.include?(user)
           wikis << wiki # only show standard users public wikis and private wikis they are a collaborator on
         end
       end
     end
     wikis # return the wikis array we've built up
   end
 end

end



    def show?
=begin
      if record.private == true && (user.admin? || user.premium?)
        true
      elsif record.private == false
        true
      end
=end
    end

    def create?
=begin
      if  record.private == true && (user.admin? || user.premium?)
        true
      elsif record.private == false
        true
      end
=end
    end

    def update?

=begin
      if record.private == true && (user.admin? || user.premium?)
        true
      elsif record.private == false
        true
      end
=end
    end

    def destroy?
=begin
      if record.private == true && (user.admin? || user.premium?)
        true
      elsif record.private == false
        true
      end
=end
end
