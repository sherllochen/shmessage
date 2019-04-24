module Shmessage
  class MessagePolicy < ::ApplicationPolicy
    def show?
      base_check('show') && (record.is_a?(Message) ? can_be_read? : true)
    end

    def read?
      show?
    end

    class Scope < Scope
      def resolve
        if user.admin?
          scope.all
        else
          user.messages
        end
      end
    end

    private

    # user能否读
    def can_be_read?
      user.admin? || target_role.blank? || target_role.upcase == 'ALL' || target_role.upcase == user.role.name
    end
  end
end