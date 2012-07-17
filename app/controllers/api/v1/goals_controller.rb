class Api::V1::GoalsController < Api::ApiController
  before_filter :authenticate
  
  def index
    @goals = current_user.goals
    render :json => @goals
  end

  def create
    goal = current_user.goals.create(JSON.parse(params[:goal]))
    render :json => goal
  end
end