class UsersController < ApplicationController
  def create
    @user = User.new params[:user]
    if @user.save
      auto_login @user
      redirect_to new_goal_path, notice: "Signed up!"
    else
      redirect_to root_url
    end
  end
end