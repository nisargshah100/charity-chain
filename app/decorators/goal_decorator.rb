class GoalDecorator < Draper::Base
  decorates :goal

  def as_json(*options)
    values = { 
      :name => model.name, 
      :streaks => model.streaks
    }
  end
end
