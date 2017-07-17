class TastesController < ApplicationController
  before_action :authenticate_user!
  before_action :authorize_taste
  before_action :load_taste, only: [:show, :edit, :update]

  def index
    @tastes = Taste.all
    respond_with(@tastes)
  end

  def show
    respond_with(@taste)
  end

  def new
    @taste = Taste.new
    respond_with(@taste)
  end

  def create
    @taste = Taste.create(taste_params)
    respond_with(@taste)
  end

  def edit
    respond_with(@taste)
  end

  def update
    @taste.update(taste_params)
    respond_with(@taste)
  end

  private

  def authorize_taste
    authorize Taste
  end

  def load_taste
    @taste = Taste.find(params[:id])
  end

  def taste_params
    params.require(:taste).permit(:name)
  end
end
