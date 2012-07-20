class ContributionsController < ApplicationController
  def index
    unless params && params[:token]
      redirect_to root_path
    else
      @goal_token = params[:token]
    end
  end
  
  def show
    @contribution = Contribution.find_by_token(params[:id])
    raise ActionController::RoutingError.new('Not Found') unless @contribution
    @payment = @contribution.payment
  end
  
  def create
    goal = Goal.find_by_token params[:goal_token]
    if goal && has_valid_params(params)
      contribution = goal.process_contribution params
      # TODO: make sure the stripe token was valid & the contribution was successfully created
      redirect_to contribution_path contribution
    elsif goal
      redirect_to contributions_path token: goal.token
    else
      redirect_to root_path
    end
  end
  
  private
  
  def has_valid_params(params)
    params && params[:stripe_token] && !params[:stripe_token].empty? && params[:amount] && params[:amount].to_i > 0
  end
end