class UsersController < ApplicationController

  def show
    @user = User.find(params[:id])
    @bicycles = @user.relevant_bicycles.paginate(page: params[:page],
                                     per_page: 12)
    unless current_user == @user
      flash[:alert] = "Access denied"
      redirect_back_or user_path
    end
  end
end
