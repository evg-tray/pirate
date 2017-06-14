class ManufacturersController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]

  def index
    @manufacturers = Manufacturer.all.page(params[:page])
    respond_with(@manufacturers)
  end

  def new
    @manufacturer = Manufacturer.new
    authorize @manufacturer
    respond_with(@manufacturer)
  end

  def create
    authorize Manufacturer.new
    @manufacturer = Manufacturer.create(manufacturer_params)
    respond_with(@manufacturer)
  end

  def show
    @manufacturer = Manufacturer.find(params[:id])
    respond_with(@manufacturer)
  end

  private

  def manufacturer_params
    params.require(:manufacturer).permit(:name, :short_name)
  end
end
