class RecipesController < ApplicationController
  before_action :authenticate_user!, except: [:index, :index_pirate_diy, :show]
  before_action :load_recipe, only: [:show, :edit, :update, :add_favorites, :delete_favorites]

  respond_to :js, only: [:add_favorites, :delete_favorites]
  def index
    @recipes = Recipe.public_recipes.includes(:author).page(params[:page])
    respond_with(@recipes)
  end

  def index_pirate_diy
    @recipes = Recipe.pirate_diy.includes(:author).page(params[:page])
    respond_with(@recipes)
  end

  def new
    authorize Recipe.new
    @recipe = Recipe.new(Recipe.initial_values(current_user).except(:drops))
    respond_with(@recipe)
  end

  def create
    authorize Recipe.new
    @recipe = Recipe.create(permitted_attributes(Recipe.new).merge(author: current_user))
    respond_with(@recipe)
  end

  def show
    authorize @recipe
    @calc_values = Recipe.initial_values(current_user)
    respond_with(@recipe)
  end

  def edit
    authorize @recipe
    respond_with(@recipe)
  end

  def update
    authorize @recipe
    @recipe.update_attributes(permitted_attributes(@recipe))
    respond_with(@recipe)
  end

  def favorites
    @recipes = current_user.favorites.page(params[:page])
    respond_with(@recipes)
  end

  def add_favorites
    authorize @recipe
    @favorite = current_user.favorite_recipes.create(recipe: @recipe)
  end

  def delete_favorites
    @from_list = params[:from_list] == 'true'
    @favorite = current_user.favorite_recipes.find_by_recipe_id(@recipe.id)
    @favorite.destroy if @favorite
  end

  private

  def load_recipe
    @recipe = Recipe.find(params[:id])
  end
end
