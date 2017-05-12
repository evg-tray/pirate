module RatingsHelper
  def user_score_rating(user, recipe)
    user_score = user&.votes&.find_by(recipe_id: recipe.id)&.rating || 0
    read_only = user.nil?
    render 'recipes/rating/user_score', recipe: recipe,
           user_score: user_score, read_only: read_only
  end

  def total_score_rating(recipe)
    render 'recipes/rating/total_score', recipe: recipe
  end
end
