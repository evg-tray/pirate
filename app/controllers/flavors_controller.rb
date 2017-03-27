class FlavorsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]

  def index
    @flavors = Flavor.all
    respond_with(@flavors)
  end

  def new
    @flavor = Flavor.new
    respond_with(@flavor)
  end

  def create
    @flavor = Flavor.create(flavor_params)
    respond_with(@flavor)
  end

  def show
    @flavor = Flavor.find(params[:id])
    respond_with(@flavor)
  end

  private

  def flavor_params
    params.require(:flavor).permit(:name)
  end
end
