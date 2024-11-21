class ProfilesController < ApplicationController
  def show
    @user = User.find(params[:id])
    @products = @user.products
  end

  def update
    @user = User.find(params[:id])
    @user.update(user_params)
    redirect_to profile_path(@user)
  end

  private

  def user_params
    params.require(:user).permit(:last_name, :first_name, :username, :address, :email, :photo, :description)
  end
end
