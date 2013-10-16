class BicyclesController < ApplicationController
  before_filter :user_signed_in? 

  def new
    if signed_in?
      @bicycle = Bicycle.new
    else
      redirect_to new_user_session_path
    end
  end

  def create
    @bicycle = current_user.bicycles.new(bicycle_params)
    if @bicycle.save
      render 'show'
    else
      respond_to do |format|
        format.html { render 'new' }
        format.js
      end
    end
  end

  def edit
    @bicycle = Bicycle.find(params[:id])
  end

  def update
    redirect_to bicycle_path(params[:id])
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
      :photo,
      :user_id
    )
  end

end
