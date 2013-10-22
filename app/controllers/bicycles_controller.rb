class BicyclesController < ApplicationController
  before_filter :user_signed_in? 

  def index
    if params[:query]
      @bicycles = Bicycle.flexible_search(params[:query]).
                          paginate(page: params[:page],
                                   per_page: 15).
                          order('date DESC')
    end
  end

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
      redirect_to bicycle_path(@bicycle)
    else
      render 'new'
    end
  end

  def edit
    @bicycle = Bicycle.find(params[:id])
  end

  def update
    @bicycle = Bicycle.find(params[:id])
    if @bicycle.update(bicycle_params)
      redirect_to bicycle_path(params[:id])
    else
      render 'edit'
    end
  end

  def show
    @bicycle = Bicycle.find(params[:id])
  end

  def destroy
    @bicycle = Bicycle.find(params[:id])
    if current_user = @bicycle.user
      @bicycle.destroy
      redirect_to user_path(current_user)
    else
      redirect_to user_path(current_user), notice: 'Access denied!'
    end
  end

  private

  def bicycle_params
    params.require(:bicycle).permit(:date, :city, :region, :country, :postal_code,
                                    :serial, :verified_ownership, :police_report,
                                    :description, :reward, :year, :brand, :model,                          
                                    :color, :size, :size_type, :photo, :user_id)
  end
end
