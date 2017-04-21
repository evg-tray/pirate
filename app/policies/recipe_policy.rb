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

  def permitted_attributes
    params = BASE_PARAMS.map(&:clone)
    params.delete(:public) if record.public
    if user.is_admin? || user.is_moderator?
      params << :pirate_diy
    end
    params
  end

  def create?
    true
  end

  def update?
    user.is_admin? || user == record.author
  end
end
