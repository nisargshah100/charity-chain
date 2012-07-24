class Api::V1::CheckInsController < Api::ApiController
  before_filter :authenticate

  def create
    goal = current_user.goals.find_by_id(params[:goal_id])
    if goal
      check_in = goal.check_ins.create(params[:check_in])
      render :json => true
    else
      render :json => false
    end
  end 
end