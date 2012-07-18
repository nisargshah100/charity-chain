class Donation < ActiveRecord::Base
  attr_accessible :amount_cents, :amount, :goal_id
  belongs_to :project
  belongs_to :goal

  monetize :amount_cents
end
