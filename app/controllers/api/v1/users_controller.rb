class API::V1::UsersController < ApplicationController

  def create
    @user = User.new(user_params)
    if @user.save
      render json: @user, except: [:first_name_public, :last_name_public, :email_public, :created_at, :updated_at, :encrypted_password, :reset_password_token, :reset_password_sent_at, :remember_created_at, :sign_in_count, :current_sign_in_at, :last_sign_in_at, :current_sign_in_ip, :last_sign_in_ip, :admin, :deleted_at],
        status: :created 
    else
      render json: @user.errors, status: :unprocessable_entity 
    end
  end

private

  def user_params
    params.require(:user).permit(:first_name, :last_name, :country, :city, :region, :postal_code, :phone1, :phone2, :email, :password, :password_confirmation, :first_name_public, :last_name_public, :email_public)
  end              
end

