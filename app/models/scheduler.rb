class Scheduler < ActiveRecord::Base
  attr_accessible :sunday, :monday, :tuesday, :wednesday, :thursday, :friday, :saturday, :goal
  belongs_to :goal

  def generate_dates
    
  end
end
