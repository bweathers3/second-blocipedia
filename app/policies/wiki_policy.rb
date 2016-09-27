
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

       all_wikis = scope.all
       all_wikis.each do |wiki|

         if  wiki.private == false || wiki.user_id == @user.id || wiki.collaborating_users.include?(@user)
           wikis << wiki # if the user is premium, only show them public wikis, or that private wikis they created, or private wikis they are a collaborator on
         end
       end
     else # standard user
       all_wikis = scope.all
       wikis = []
       all_wikis.each do |wiki|
         if wiki.private == false || wiki.collaborating_users.include?(@user)
           wikis << wiki # only show standard users public wikis and private wikis they are a collaborator on
         end
       end
     end
     wikis # return the wikis array we've built up
   end
 end

  def update
    individual_scope
  end

  def create
    individual_scope
  end

  def destroy
    individual_scope
  end



  private

  def individual_scope
    return true if user.admin?
    return true if @wiki.user_id == @user.id
    return true if @wiki.collaborating_users.include?(@user)
    return true if @wiki.private == false
    return false
  end

 end
