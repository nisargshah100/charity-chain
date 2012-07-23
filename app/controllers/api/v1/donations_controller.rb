class Api::V1::DonationsController < Api::ApiController
  before_filter :authenticate

  def create
    goal = current_user.goals.find_by_id(params[:donation].delete(:goal_id))
    project = Project.find_by_external_id(params[:donation][:project_id])

    if goal && project
      donation = goal.donations.build(params[:donation])
      
      if donation.save
        return render :json => donation
      else
        return render :json => donation.errors.full_messages, :status => :not_found
      end
    end

    render :json => 'There was an error', :status => :not_found
  end
end