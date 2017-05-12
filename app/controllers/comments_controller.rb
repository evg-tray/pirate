class CommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_recipe, only: [:create]

  respond_to :js, only: [:create]

  def create
    @comment = @recipe.comments.create(comment_params)
    respond_with(@comment)
  end

  private

  def set_recipe
    @recipe = Recipe.find(params[:recipe_id])
  end

  def comment_params
    params.require(:comment).permit(:text).merge(author_id: current_user.id)
  end
end
