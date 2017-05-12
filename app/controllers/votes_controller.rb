class VotesController < ApplicationController
  before_action :authenticate_user!

  respond_to :js, only: [:vote_recipe]

  def vote_recipe
    Vote.vote_recipe(current_user, params[:recipe_id], params[:score])
  end
end
