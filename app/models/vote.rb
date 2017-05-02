class Vote < ApplicationRecord
  belongs_to :user
  belongs_to :recipe

  after_commit :update_rating

  private

  def update_rating
    self.recipe.update_attributes(
        average_rating: recipe.votes.average(:rating)&.round(2) || 0,
        count_rating: recipe.votes.count
    )
  end
end
