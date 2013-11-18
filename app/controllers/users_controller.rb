class UsersController < ApplicationController

  def show
    @user = User.find(params[:id])
    unless current_user == @user
      flash[:alert] = "Access denied"
      redirect_back_or user_path
    end
  end

  def index
    if params[:query_user] && current_user.admin?
      @users = User.fuzzy_search(params[:query_user])
      @users = @users.paginate(page: params[:page],
                                     per_page: 10)
    end
  end
end
