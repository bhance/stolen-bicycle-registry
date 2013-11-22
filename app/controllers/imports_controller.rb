class ImportsController < ApplicationController
  def create
    users_csv = params[:user_file].tempfile
    bicycles_csv = params[:bicycle_file].tempfile if params[:bicycle_file]
    Import.new(users_csv, bicycles_csv)
    flash[:notice] = "Import Successful"
    redirect_to user_path(current_user)
  end

  def new
  end
end
