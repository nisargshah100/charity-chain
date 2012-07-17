class SessionsController < ApplicationController
  def create
    user = login params[:email], params[:password]
    if user
      redirect_to goals_path, notice: "Logged in!"
    else
      flash.now.alert = "Email or password was invalid"
      redirect_to root_url
    end
  end
  
  def destroy
    logout
    redirect_to root_url, notice: "Logged out"
  end
end
