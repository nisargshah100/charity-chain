class Contribution < ActiveRecord::Base
  include TokenHelper
  
  attr_accessible :payment_id, :goal_id, :amount_per_check_in_cents, :email, :name, :token
  
  belongs_to :goal
  has_one :payment
  
  after_create :set_token
  delegate :amount, to: :payment
  
  def to_param
    token
  end
  
  private
  
  def set_token
    update_attribute(:token, create_token("#{name}#{email}#{rand(100000)}"))
  end
end