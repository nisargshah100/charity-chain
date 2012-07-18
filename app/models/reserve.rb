class Reserve < ActiveRecord::Base
  attr_accessible :amount_cents
  belongs_to :goal
  monetize :amount_cents
end
