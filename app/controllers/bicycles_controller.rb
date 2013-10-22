class BicyclesController < ApplicationController

  before_filter :user_signed_in? 
  # before_action :user_signed_in?, except: or only: ??? [:new, :create, :edit, :show] #fixme remove comments
  # suggested rails 4 ways? by Michal

  def index
    if params[:query]
      @bicycles = Bicycle.bicycle_search(params[:query])
      if @bicycles
        @bicycles = @bicycles.paginate(page: params[:page], :per_page => 15).order('date DESC') #fixme move to line 8 after updating search
      end
    end

    @bicycles #fixme do we really need this?
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

  private

  def bicycle_params
    params.require(:bicycle).permit(:date, #fixme put a few of these on the same line - 100 char ruler
                                    :city,
                                    :region,
                                    :country,
                                    :postal_code,
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
                                    :user_id)
  end
end
