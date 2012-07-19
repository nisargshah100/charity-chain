class Contribution < ActiveRecord::Base
  attr_accessible :payment_id, :goal_id, :amount_per_check_in_cents, :email, :name, :user_id, :token
  
  belongs_to :goal
  has_one :payment
  
  after_create :set_token
  
  private
  
  def set_token
    update_attribute(:token, create_token("#{name}#{email}#{rand(100000)}"))
  end
end
