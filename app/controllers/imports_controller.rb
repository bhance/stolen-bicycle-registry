class ImportsController < ApplicationController
  def create
    Import.create(params[:file])
    redirect_to user_path(current_user), notice: "Bicycles imported"
  end
end
