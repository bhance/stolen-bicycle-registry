class ImportsController < ApplicationController
  def create
    Import.new(params[:file]).add
    redirect_to user_path(current_user), notice: "Bicycles imported"
  end
end
