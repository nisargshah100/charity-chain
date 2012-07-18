class UsersController < ApplicationController
  def create
    @user = User.new params[:user]
    if @user.save
      auto_login @user
      render :json => { created_user: true }
    else
      render :json => { created_user: false }
    end
  end
end