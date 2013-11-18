class API::V1::BicyclesController < ApplicationController
  respond_to :json
  def index
    if params[:query]
      @bicycles = Bicycle.flexible_search(params[:query]).order('date DESC')
    else
      @bicycles = Bicycle.all.order('date DESC')
    end
    render json: @bicycles, except: [:approved, :hidden, :created_at, :updated_at,
                                     :photo_file_name, :photo_content_type, :photo_updated_at,
                                     :photo_file_size, :user_id, :verified_ownership]
  end
end
