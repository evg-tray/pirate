class SelectsController < ApplicationController

  def select
    begin
      if params[:adapter].present?
        adapter = "#{params[:adapter].capitalize}SelectAdapter".constantize
      else
        render json: {error: "Недостаточно параметров"}.to_json, status: 500
        return
      end
    rescue NameError
      render json: {error: "Несуществующий адаптер."}.to_json, status: 500
      return
    end
    page = params[:page]&.to_i || 0
    page = 1 if page == 0
    render json: adapter.select(params[:term], page).to_json
  end
end
