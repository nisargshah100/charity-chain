class Api::V1::GoalsController < Api::ApiController
  before_filter :authenticate
  
  def index
    @goals = current_user.goals
    render :json => GoalDecorator.decorate(@goals)
  end

  def create
    goal = current_user.goals.create(JSON.parse(params[:goal]))
    goal.create_scheduler(JSON.parse(params[:scheduler]))
    render :json => GoalDecorator.decorate(goal)
  end

  def update
    goal = current_user.goals.find(params[:id])
    goal.update_attributes(params[:goal])
    goal.save()
    render :json => GoalDecorator.decorate(goal)
  end
end