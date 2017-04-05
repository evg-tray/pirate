class RecipesController < ApplicationController
  before_action :authenticate_user!, except: [:index, :index_pirate_diy, :show]
  before_action :load_recipe, only: [:show, :edit, :update]

  def index
    @recipes = Recipe.public_recipes
    respond_with(@recipes)
  end

  def index_pirate_diy
    @recipes = Recipe.pirate_diy
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

  private

  def load_recipe
    @recipe = Recipe.find(params[:id])
  end
end
