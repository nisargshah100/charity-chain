class GoalDecorator < Draper::Base
  decorates :goal

  def as_json(*options)
    values = { 
      :id => model.id,
      :name => model.name, 
      :streaks => model.streaks,
      :checked_in_today => model.checked_in_today?
    }
  end
end
