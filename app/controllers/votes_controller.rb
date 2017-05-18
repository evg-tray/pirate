class VotesController < ApplicationController
  before_action :authenticate_user!

  respond_to :js, only: [:vote_recipe]

  def vote_recipe
    VoteRecipe.call(user: current_user, recipe_id: params[:recipe_id], score: params[:score])
  end
end
