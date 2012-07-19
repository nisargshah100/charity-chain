class ContributionsController < ApplicationController
  def index
    unless params && params[:token]
      redirect_to root_path
    else
      @goal_token = params[:token]
    end
  end
  
  def show
  end
  
  def create
  end
end