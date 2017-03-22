class RecipesController < ApplicationController

  add_flash_types :error, :success, :info

  def index
    @recipes = Recipe.all
    respond_with(@recipes)
  end

  def new
    @recipe = Recipe.new(Recipe.load_values)
    respond_with(@recipe)
  end

  def create
    @recipe = Recipe.create(recipe_params)
    respond_with(@recipe)
  end

  def show
    @recipe = Recipe.find(params[:id])
    respond_with(@recipe)
  end

  private

  def recipe_params
    params.require(:recipe).permit(
        :name,
        :amount,
        :strength,
        :pg,
        :vg,
        :nicotine_base,
        flavors_recipes_attributes: [:id, :_destroy, :flavor_id, :amount]
    )
  end
end
