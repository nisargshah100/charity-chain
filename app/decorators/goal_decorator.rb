class GoalDecorator < Draper::Base
  decorates :goal

  def as_json(*options)
    values = { 
      :id => model.id,
      :name => model.name, 
      :streaks => model.streaks,
      :can_check_in => model.can_check_in?,
      :wallet_amount => model.wallet.amount.to_s,
      :reserve_amount => model.reserve.amount.to_s,
      :sponsors => model.sponsors,
      :donation_total => model.donation_total.to_s,
      :project => Project.fetch(3).map { |p| JSON.parse(p.data)},
      :contribute_url => short_contribution_link
    }
  end
  
  private
  
  def short_contribution_link
    h.root_url + model.token
  end
  
end
