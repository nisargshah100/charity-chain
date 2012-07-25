class ContributionsController < ApplicationController
  before_filter :ensure_goal_by_token, only: :create

  def index
    @goal = Goal.find_by_token params[:id]
    if @goal
      @user_name = @goal.user.name
      @project = Hashie::Mash.new(JSON.parse(Project.where(:active => true).first.data))
    else
      redirect_to root_path
    end
  end
  
  def show
    @contribution = Contribution.find_by_token(params[:id])
    raise ActionController::RoutingError.new('Not Found') unless @contribution
    @payment = @contribution.payment
  end
  
  # TODO: make sure the stripe token was valid & the contribution was successfully created
  def create
    if has_valid_contribution_params(params)
      contribution = Contribution.process @goal, params
      redirect_to contribution_path contribution
    else
      redirect_to contributions_path(token: @goal.token)
    end
  end
  
  private
  
  def has_valid_contribution_params(params)
    !params[:stripe_token].blank? && params[:amount].to_i > 0
  end

  def ensure_goal_by_token
    @goal = Goal.find_by_token params[:goal_token]
    redirect_to root_path unless @goal and return
  end

end