class UsersController < ApplicationController
  def index
  end

  def new
  end

  def create
  end

  def show
    @user = User.find(params[:id])
    unless current_user == @user
      flash[:alert] = "Access denied"
      redirect_back_or user_path
    end
  end

  def edit
  end

  def update
  end

  def destroy
  end

end