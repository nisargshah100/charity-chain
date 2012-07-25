class SessionsController < ApplicationController
  def create
    logout # kill an existing auth if present
    user = login params[:email], params[:password]
    render :json => { logged_in: logged_in? }
  end
  
  def destroy
    logout
    redirect_to root_path, notice: "Logged out"
  end
end
