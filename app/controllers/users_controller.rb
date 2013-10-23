class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    unless current_user == @user
      flash[:alert] = "Access denied"
      redirect_back_or user_path
    end
  end
end
