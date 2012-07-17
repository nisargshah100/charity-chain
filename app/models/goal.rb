class Goal < ActiveRecord::Base
  attr_accessible :check_in_interval, :name, :reserve_amount_cents, :user_id, :wallet_amount_cents, :user
  belongs_to :user
  has_many :check_ins
  has_one :scheduler
end
