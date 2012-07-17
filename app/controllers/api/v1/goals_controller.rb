class Api::V1::GoalsController < Api::ApiController
  before_filter :authenticate
  
  def create
    current_user.create_goal(params[:goal])
  end
end