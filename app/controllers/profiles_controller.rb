class ProfilesController < ApplicationController
  def show
    @user = current_user
    @profil = User.find(@user.id)
  end
end
