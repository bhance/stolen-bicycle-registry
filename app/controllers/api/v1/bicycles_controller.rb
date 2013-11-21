class API::V1::BicyclesController < ApplicationController
  serialization_scope nil

  def index
    if params[:query]
      @bicycles = Bicycle.flexible_search(params[:query])
    else
      @bicycles = Bicycle.all
    end
    render json: @bicycles
  end

  def create
    @bicycle = Bicycle.new(bicycle_params)
    if @bicycle.save
      render json: @bicycle, status: :created 
    else
      render json: @bicycle.errors, status: :unprocessable_entity 
    end
  end

private

  def bicycle_params
    params.require(:bicycle).permit(:date, :city, :region, :country, :postal_code,
                   :serial, :verified_ownership, :police_report,
                   :description, :reward, :year, :brand, :model,
                   :color, :size, :size_type, :photo, :user_id,
                   :recovered, :hidden)
  end              
end
