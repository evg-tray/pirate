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
      :public,
      flavors_recipes_attributes: [:id, :_destroy, :flavor_id, :amount]
  ]
  PUBLIC_PARAMS = [:public]
  PIRATE_DIY_PARAMS = [:pirate_diy]

  def permitted_attributes
    attrs = if user.is_admin? || user.is_moderator?
              BASE_PARAMS + PIRATE_DIY_PARAMS
            else
              BASE_PARAMS
            end

    if record.public
      attrs
    else
      attrs + PUBLIC_PARAMS
    end
  end

  def create?
    true
  end

  def update?
    user.is_admin? || user == record.author
  end

  def add_favorites?
    (user && record.public) || user == record.author
  end
end
