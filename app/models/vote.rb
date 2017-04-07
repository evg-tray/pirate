class Vote < ApplicationRecord
  belongs_to :user
  belongs_to :recipe

  after_commit :update_rating

  def self.vote_recipe(user, recipe_id, score)
    score = score.to_i
    @vote = Vote.where(recipe_id: recipe_id, user_id: user.id).first
    if (1..5).include?(score)
      unless @vote
        @vote = Vote.new(recipe_id: recipe_id, user_id: user.id)
      end
      @vote.rating = score
      @vote.save
    elsif score == 0
      @vote.destroy if @vote
    end
  end

  private

  def update_rating
    self.recipe.update_attributes(
        average_rating: recipe.votes.average(:rating)&.round(2) || 0,
        count_rating: recipe.votes.count
    )
  end
end
