class UserImportsController < ApplicationController
  def create
    UserImport.new(params[:file])
    redirect_to user_path(current_user), notice: "Bicycles imported"
  end
end
