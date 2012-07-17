class CheckIn < ActiveRecord::Base
  attr_accessible :goal_id
  belongs_to :goal
  
end
