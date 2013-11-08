class BicyclesController < ApplicationController
  authorize_resource

  def index
    if params[:query]
      @bicycles = Bicycle.flexible_search(params[:query])
      @bicycles = @bicycles.paginate(page: params[:page],
                                     per_page: 10).
                            order('date DESC')
    end
  end

  def admin_update
    @bicycle = Bicycle.find(params[:id])
  end

  def new
    if signed_in?
      @bicycle = Bicycle.new(region: current_user.region, city: current_user.city,
                                                   country: current_user.country)
    else
      redirect_to sign_in_path
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
    respond_to do |format|
      format.html do
        if @bicycle.update(bicycle_params)
          flash[:notice] = "Bicycle status updated"
          redirect_to bicycle_path(@bicycle)
        else
          render 'edit'
        end
      end
      format.js do
        @bicycle.update(bicycle_params)
      end
    end
  end

  def show
    @bicycle = Bicycle.find(params[:id])
  end

  def destroy
    @bicycle = Bicycle.find(params[:id])
    if current_user.admin?
      @bicycle.destroy!
      redirect_to user_path(current_user)
    elsif current_user == @bicycle.user
      @bicycle.update(deleted: true)
      redirect_to user_path(current_user)
    else
      redirect_to user_path(current_user), notice: 'Access denied!'
    end
  end

  private

  def bicycle_params
    base_params = [:date, :city, :region, :country, :postal_code,
                   :serial, :verified_ownership, :police_report,
                   :description, :reward, :year, :brand, :model,
                   :color, :size, :size_type, :photo, :user_id,
                   :recovered, :hidden]
    if current_user.admin?
      params.require(:bicycle).permit(*(base_params << :approved))
    else
      params.require(:bicycle).permit(*base_params)
    end
  end
end
