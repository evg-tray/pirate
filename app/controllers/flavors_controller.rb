class FlavorsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]

  respond_to :js, only: [:add_to_my_flavors, :update_availability, :delete_from_my_flavors]

  def index
    @flavors = Flavor.all.includes(:manufacturer).page(params[:page])
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
    @flavor = Flavor.find(params[:id])
    respond_with(@flavor)
  end

  def my_flavors
    @flavors = current_user.flavors.includes(flavor: [:manufacturer]).page(params[:page])
    respond_with(@flavors)
  end

  def add_to_my_flavors
    @user_flavor = current_user.flavors.create(flavor_id: params[:flavor_id])
    respond_with(@flavor)
  end

  def delete_from_my_flavors
    @user_flavor = current_user.flavors.find(params[:id])
    @user_flavor.destroy
    respond_with(@user_flavor)
  end

  def update_availability
    @user_flavor = current_user.flavors.find(params[:id])
    @user_flavor.update_attributes(available: !@user_flavor.available)
    respond_with(@user_flavor)
  end

  private

  def flavor_params
    params.require(:flavor).permit(:name, :manufacturer_id)
  end
end
