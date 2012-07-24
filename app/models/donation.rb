class Donation < ActiveRecord::Base
  attr_accessible :amount_cents, :amount, :goal_id, :project_id
  belongs_to :project
  belongs_to :goal

  monetize :amount_cents
  after_save :reduce_wallet_amount, :reduce_reserve_amount

  validate :ensure_less_than_wallet
  validate :ensure_less_than_reserve

  extend Forwardable
  def_delegators :goal, :wallet, :reserve


  def ensure_less_than_wallet
    if amount > goal.wallet_amount
      errors.add(:amount, "must be less than wallet ($#{goal.wallet_amount})")
    end
  end

  def ensure_less_than_reserve
    if amount > goal.reserve_amount
      errors.add(:amount, "must be less than reserve ($#{goal.reserve_amount})")
    end
  end

  private

  def reduce_wallet_amount
    wallet.update_attribute(:amount, goal.wallet_amount - amount)
  end

  def reduce_reserve_amount
    reserve.update_attribute(:amount, goal.reserve_amount - amount)
  end
end
