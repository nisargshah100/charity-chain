class GoalDecorator < Draper::Base
  decorates :goal

  def as_json(*options)
    values = { 
      :name => model.name, 
      :current_streak => model.current_streak_length
    }
  end
end
