class UsersController < ApplicationController
  def create
    @user = User.new params[:user]
    if @user.save
      redirect_to goals_show_path(1), notice: "Signed up!"
    else
      redirect_to root_url
    end
  end
end