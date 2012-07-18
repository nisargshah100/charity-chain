class Wallet < ActiveRecord::Base
  # attr_accessible :title, :body
  belongs_to :goal
  monetize :amount_cents
end
