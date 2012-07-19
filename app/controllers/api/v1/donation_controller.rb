class Api::V1::DonationController < Api::ApiController
  before_filter :authenticate

  def index
    goal = current_user.goals.where(:id => params[:goal_id]).first
    if goal
      donation = goal.donations.create(params[:donation])
      
      if donation.id?
        render :json => donation
      else
        render :json => donation.errors
      end
    end
  end
end
