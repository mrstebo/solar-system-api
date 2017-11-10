class PlanetsController < ApplicationController
  def index
    render json: Planet.all
  end

  def show
    render json: Planet.where(Planet.arel_table[:name].matches(params[:id])).first
  end
end
