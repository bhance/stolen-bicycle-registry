class UsersController < ApplicationController
  def index #fixme remove unneeded methods and views
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
