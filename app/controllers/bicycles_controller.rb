class BicyclesController < ApplicationController
  def index
    if params[:serial]
      @bicycles = Bicycle.serial_search(params[:serial]).paginate(page: params[:page], :per_page => 15).order('date DESC')
    elsif params[:advanced]
      @bicycles = Bicycle.all #temporary
    else
      @bicycles = Bicycle.all.paginate(page: params[:page], :per_page => 15).order('date DESC')
    end
  end

  def new
    @bicycle = Bicycle.new
  end

  def create
    @bicycle = Bicycle.new(bicycle_params)
    if @bicycle.save
      render 'show'
    else
      respond_to do |format|
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
