class GoalDecorator < Draper::Base
  decorates :goal

  def as_json(*options)
    values = { 
      :id => model.id,
      :name => model.name, 
      :streaks => model.streaks,
      :checked_in_today => model.checked_in_today?,
      :wallet_amount => model.wallet.amount.to_s,
      :reserve_amount => model.reserve.amount.to_s,
      :sponsors => model.sponsors,
      :donation_total => model.donation_total.to_s,
      :project => Project.fetch(3).map { |p| JSON.parse(p.data) }
    }
  end
end
