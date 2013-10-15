class BicyclesController < ApplicationController

  def new
    @bicycle = Bicycle.new
  end

  def create
    @bicycle = Bicycle.new(bicycle_params)
    if @bicycle.save
      render 'show'
    else
      respond_to do |format|
        puts 'You made it to the sad path!'
        format.html { render 'new' }
        format.js
      end
    end
  end

  private

  def bicycle_params
    params.require(:bicycle).permit(
      :date,
      :city,
      :region,
      :country,
      :zip,
      :serial,
      :verified_ownership,
      :police_report,
      :description,
      :reward,
      :year,
      :brand,
      :model,
      :color,
      :size,
      :size_type,
      :photo
    )
  end

end
