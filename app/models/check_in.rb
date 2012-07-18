class CheckIn < ActiveRecord::Base
  attr_accessible :goal_id, :date
  belongs_to :goal
  default_scope :order => 'date DESC'
end
