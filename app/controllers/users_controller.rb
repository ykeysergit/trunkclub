class UsersController < ApplicationController
  def create
    render json: User.create!
  end
  
  def show
    render json: User.find(params[:id].to_i)
  end
  
  def delete
    @user=User.find(params[:id])
    @user.destroy
    render json:@user
  end
end