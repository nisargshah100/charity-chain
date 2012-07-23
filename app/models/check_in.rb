class CheckIn < ActiveRecord::Base
  attr_accessible :goal_id, :date
  belongs_to :goal
  default_scope :order => 'date DESC'

  after_create :increase_wallet

  private

  def increase_wallet
    self.goal.wallet.increase
  end
end
