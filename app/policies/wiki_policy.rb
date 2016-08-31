
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
        if user.admin? || user.premium?
          scope.all
        else
          scope.where(private: false)
        end
      end
    end



    def show?
      if record.private == true && (user.admin? || user.premium?)
        true
      elsif record.private == false
        true
      end
    end

    def create?
      if  record.private == true && (user.admin? || user.premium?)
        true
      elsif record.private == false
        true
      end
    end

    def update?
      if record.private == true && (user.admin? || user.premium?)
        true
      elsif record.private == false
        true
      end
    end

    def destroy?
      if record.private == true && (user.admin? || user.premium?)
        true
      elsif record.private == false
        true
      end
    end


end
