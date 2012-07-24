class ContributionsController < ApplicationController
  def index
    @goal = Goal.find_by_token params[:id]
    if @goal
      @user_name = @goal.user.name
      @project_image_url = "sample_project.jpeg"
      @project_title = "Sensory Integration in Speech Therapy"
      @project_school_name = "Ps 11 William T Harris"
      @project_city = "New York City"
      @project_state = "NY"
      @project_proposal_url = "http://donorschoose.org"
    else
      redirect_to root_path
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
      contribution = Contribution.process goal, params
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