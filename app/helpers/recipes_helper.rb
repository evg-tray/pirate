module RecipesHelper
  def recipe_status(user, recipe)
    return if user.nil?
    if (user == recipe.author || user.is_admin?) && ! recipe.pirate_diy
      "<i class=\"fa fa-eye#{'-slash' unless recipe.public}\"
      title=\"#{recipe.public ? t('recipes.public') : t('recipes.private')}\"></i>&nbsp".html_safe
    end
  end
end
