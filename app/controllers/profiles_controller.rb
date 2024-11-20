class ProfilesController < ApplicationController
  def show
    @user = User.find(params[:id])
    if @user = current_user
    end
  end
end
