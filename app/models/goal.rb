class Goal < ActiveRecord::Base
  include TokenHelper
  include StripeHelper
  
  attr_accessible :check_in_interval, :name, :user_id, :user, :created_at, :token
  belongs_to :user
  has_many :check_ins
  has_many :donations
  has_many :contributions
  has_one :scheduler
  has_one :wallet
  has_one :reserve

  after_create :ensure_wallet, :ensure_reserve, :set_token

  # Calculates all streaks up to a specified end date
  #
  # Example:
  #  goal.streaks("21/6/1988")
  #  #=> [5, 30, 10]
  #
  # @param [DateTime] end_date The date up to which streaks are calculated
  # @return [Array] kind An array of integers representing streak lengths for an instance of a goal.
  def streaks(end_date = DateTime.now)
    streak, streaks = 0, []
    dates = scheduler.generate_dates(end_date)
    checkins = Set.new check_ins.pluck('date').map(&:to_date)

    dates.unshift Date.today if checked_in_today?

    dates.each do |date|
      unless checkins.include?(date)
        streaks << streak 
        streak = 0
      else
        streak += 1
      end
    end

    streaks << streak
  end

  def checked_in_today?
    check_ins.where("date >= ? AND date < ?", Date.today, Date.today + 1).present?
  end

  def donation_total
    Money.new donations.pluck(:amount_cents).inject(0, :+)
  end

  def sponsors
    contributions.pluck(:name)
  end

  def process_contribution(params)
    # TODO: fix me; this probably doesn't belong since Payment and Contribution details are here for all to see
    charge = process_transaction id, params
    payment = Payment.create(amount: charge.amount.to_i, data: charge, card_type: charge.card.type, last_four: charge.card.last4)
    contribution = contributions.create(payment_id: payment.id, name: params[:cardholder_name])
    payment.update_attribute(:contribution_id, contribution.id)
    contribution
  end

  private

  def ensure_wallet
    wallet || create_wallet
  end

  def ensure_reserve
    reserve || create_reserve
  end
  
  def set_token
    update_attribute(:token, create_token("#{name}#{user_id}#{rand(100000)}"))
  end
end
