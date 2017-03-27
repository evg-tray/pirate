class RecipesController < ApplicationController
  before_action :authenticate_user!, except: [:index, :pirate_diy, :show]
  before_action :load_recipe, only: [:show, :edit, :update]

  def index
    @recipes = Recipe.published
    respond_with(@recipes)
  end

  def pirate_diy
    @recipes = Recipe.pirate_diy
    respond_with(@recipes)
  end

  def new
    @recipe = Recipe.new(Recipe.load_values)
    respond_with(@recipe)
  end

  def create
    @recipe = Recipe.create(recipe_params.merge(author: current_user))
    respond_with(@recipe)
  end

  def show
    respond_with(@recipe)
  end

  def edit
    respond_with(@recipe)
  end

  def update
    @recipe.update_attributes(recipe_params)
    respond_with(@recipe)
  end

  private

  def load_recipe
    @recipe = Recipe.find(params[:id])
  end

  def recipe_params
    params.require(:recipe).permit(
        :name,
        :amount,
        :strength,
        :pg,
        :vg,
        :nicotine_base,
        :published,
        :pirate_diy,
        flavors_recipes_attributes: [:id, :_destroy, :flavor_id, :amount]
    )
  end
end
