class SearchesController < ApplicationController

  def show
    if params[:query] && params[:scope]
      @results = Search.results(params[:query], params[:scope], params[:page])
      respond_with(@results)
    end
  end
end
