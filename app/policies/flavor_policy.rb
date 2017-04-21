class FlavorPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope
    end
  end

  def create?
    user.is_admin? || user.is_moderator?
  end
end
