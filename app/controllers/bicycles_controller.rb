class BicyclesController < ApplicationController
  def new
    @bicycle = Bicycle.new
  end

  def create

  end

  private

  def bicycle_params
    params.require(:bicycle).permit(
      :date,
      :city,
      :state,
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
      :size_type
    )
  end
end
