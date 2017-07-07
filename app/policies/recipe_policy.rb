class RecipePolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope
    end
  end

  BASE_PARAMS = [
      :name,
      :amount,
      :strength,
      :pg,
      :vg,
      :nicotine_base,
      taste_ids: [],
      flavors_recipes_attributes: [:id, :_destroy, :flavor_id, :amount]
  ]
  PUBLIC_PARAMS = [:public]
  PIRATE_DIY_PARAMS = [:pirate_diy]

  def permitted_attributes
    if user.is_admin? || user.is_moderator? || user.is_pirate_diy_creator?
      BASE_PARAMS + PIRATE_DIY_PARAMS + PUBLIC_PARAMS
    else
      if user.confirmed?
        BASE_PARAMS + PUBLIC_PARAMS
      else
        BASE_PARAMS
      end
    end
  end

  def create?
    user
  end

  def update?
    user && (user.is_admin? || user == record.author)
  end

  def add_favorites?
    user && (record.public || user == record.author)
  end

  def show?
    record.public || user&.is_admin? || (user && record.author == user)
  end

  def destroy?
    update?
  end
end
