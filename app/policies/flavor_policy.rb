class FlavorPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope
    end
  end

  def create?
    user && (user.is_admin? || user.is_moderator? || user.is_flavor_creator?)
  end

  def edit?
    create?
  end

  def update?
    edit?
  end
end
