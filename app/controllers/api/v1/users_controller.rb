class API::V1::UsersController < ApplicationController
  serialization_scope nil

  def create 
    @user = User.new(user_params)
    if @user.save
      render json: @user, status: :created 
    else
      render json: @user.errors, status: :unprocessable_entity 
    end
  end

private
  
  def user_params
    params.require(:user).permit(:first_name, :last_name, :country, :city, :region, :postal_code, 
                          :phone1, :phone2, :email, :password, :password_confirmation, :first_name_public,
                          :last_name_public, :email_public, bicycles_attributes: [ :date, :city, :region,
                          :state, :country, :postal_code, :serial, :verified_ownership, :police_report,
                          :description, :reward, :year, :brand, :model, :color, :size, :size_type ] )
  end              
end

