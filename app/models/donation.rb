class Donation < ActiveRecord::Base
  attr_accessible :amount_cents, :amount, :goal_id
  belongs_to :project
  belongs_to :goal

  monetize :amount_cents
  after_save :reduce_wallet_amount, :reduce_reserve_amount

  validate do |donation|
    amount = donation.goal.wallet.amount
    if donation.amount > donation.goal.wallet.amount
      donation.errors.add(:amount, "Donation amount must be less then wallet ($#{amount})")
    end

    amount = donation.goal.reserve.amount
    if donation.amount > donation.goal.reserve.amount
      donation.errors.add(:amount, "Donation amount must be less then reserve ($#{amount})")
    end
  end

  private

  def reduce_wallet_amount
    wallet = goal.wallet
    wallet.amount = wallet.amount - self.amount
    wallet.save()
  end

  def reduce_reserve_amount
    reserve = goal.reserve
    reserve.amount = reserve.amount - self.amount
    reserve.save()
  end
end
