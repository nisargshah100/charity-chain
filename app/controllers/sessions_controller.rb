class SessionsController < ApplicationController
  def create
    user = login params[:email], params[:password]
    render :json => { logged_in: !user.nil? }
  end
  
  def destroy
    logout
    redirect_to root_url, notice: "Logged out"
  end
end
