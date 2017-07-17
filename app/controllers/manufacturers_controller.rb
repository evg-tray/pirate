class ManufacturersController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :load_manufacturer, only: [:show, :edit, :update]

  def index
    @manufacturers = Manufacturer.sorted.all.page(params[:page])
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
    @flavors = @manufacturer.flavors.sorted.page(params[:page])
    respond_with(@manufacturer)
  end

  def edit
    authorize @manufacturer
    respond_with(@manufacturer)
  end

  def update
    authorize @manufacturer
    @manufacturer.update(manufacturer_params)
    respond_with(@manufacturer)
  end

  private

  def manufacturer_params
    params.require(:manufacturer).permit(:name, :short_name)
  end

  def load_manufacturer
    @manufacturer = Manufacturer.find(params[:id])
  end
end
