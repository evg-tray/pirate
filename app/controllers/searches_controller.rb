class SearchesController < ApplicationController
  before_action :authenticate_user!, only: [:fill_my_flavors]
  respond_to :js, only: [:fill_my_flavors]

  def show
    if params[:query] && params[:scope]
      @results = Search.by_name(params[:query], params[:scope]).page(params[:page]).load(scope: ->{ includes(:author) })
      respond_with(@results)
    end
  end

  def by_flavors
    if params[:flavor_ids]
      flavor_ids = Search.escape_flavor_ids(params[:flavor_ids])
      @flavors = Flavor.where(id: flavor_ids)
      @results = Search.by_flavors(flavor_ids, params[:without_single_flavor]).page(params[:page])
      respond_with(@results)
    end
  end

  def fill_my_flavors
    @flavors = current_user.available_flavors
  end
end
