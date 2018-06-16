class UsersController < ApplicationController

  before_action :set_user

  def show
    @commented_restaurants = @user.restaurants
  end

  def edit
    redirect_to user_path(@user) unless @user == current_user
  end

  def update
    @user.update(user_params)
    redirect_to user_path(@user)
  end

  private

  def user_params
    params.require(:user).permit(:name, :intro, :avatar)
  end

  def set_user
    @user = User.find(params[:id])
  end
end
