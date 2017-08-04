class FlavorsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :load_flavor, only: [:show, :edit, :update]

  respond_to :js, only: [:add_to_my_flavors, :update_availability, :delete_from_my_flavors]

  def index
    @flavors = Flavor.sorted.all.includes(:manufacturer).page(params[:page])
    respond_with(@flavors)
  end

  def new
    authorize Flavor
    @flavor = Flavor.new
    respond_with(@flavor)
  end

  def create
    authorize Flavor
    @flavor = Flavor.create(flavor_params)
    respond_with(@flavor)
  end

  def show
    @recipes = @flavor.recipes.sorted.public_pirate.includes(:author)
                   .includes(flavors_recipes: [flavor: :manufacturer]).page(params[:page])
    respond_with(@flavor)
  end

  def edit
    authorize @flavor
    respond_with(@flavor)
  end

  def update
    authorize @flavor
    @flavor.update(flavor_params)
    respond_with(@flavor)
  end

  def my_flavors
    @flavors = current_user.flavors.sorted.includes(flavor: [:manufacturer]).page(params[:page])
    respond_with(@flavors)
  end

  def add_to_my_flavors
    @user_flavor = current_user.flavors.create(flavor_id: params[:flavor_id])
    respond_with(@user_flavor)
  end

  def delete_from_my_flavors
    @user_flavor = current_user.flavors.find_by(id: params[:id])
    @user_flavor.destroy if @user_flavor
    respond_with(@user_flavor)
  end

  def update_availability
    @user_flavor = current_user.flavors.find(params[:id])
    @user_flavor.update_attributes(available: !@user_flavor.available)
    respond_with(@user_flavor)
  end

  private

  def flavor_params
    params.require(:flavor).permit(
        :name,
        :manufacturer_id,
        :description,
        :translate,
        :warning_health,
        :warning_device,
        :warning_description
    )
  end

  def load_flavor
    @flavor = Flavor.find(params[:id])
  end
end
