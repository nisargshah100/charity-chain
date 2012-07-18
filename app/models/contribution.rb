class Contribution < ActiveRecord::Base
  attr_accessible :payment_id, :goal_id, :amount_per_check_in_cents, :email, :name, :user_id

end
