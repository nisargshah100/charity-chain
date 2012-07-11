class Goal < ActiveRecord::Base
  attr_accessible :amount_cents, :days, :time_period, :title
  
  serialize :days
end
