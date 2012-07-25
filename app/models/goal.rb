class Goal < ActiveRecord::Base
  include TokenHelper

  attr_accessible :check_in_interval, :name, :user_id, :user, :created_at, :token
  belongs_to :user
  has_many :check_ins
  has_many :donations
  has_many :contributions
  has_one :scheduler
  has_one :wallet
  has_one :reserve

  after_create :ensure_wallet, :ensure_reserve, :set_token

  extend Forwardable
  def_delegator :wallet, :amount, :wallet_amount
  def_delegator :reserve, :amount, :reserve_amount

  # Calculates all streaks up to a specified end date
  #
  # Example:
  #  goal.streaks("21/6/1988")
  #  #=> [5, 30, 10]
  #
  # @param [DateTime] end_date The date up to which streaks are calculated
  # @return [Array] kind An array of integers representing streak lengths for an instance of a goal.
  def streaks(end_date = DateHelper.now)
    dates = scheduler.generate_dates(end_date)
    accumulate_streaks(dates, check_in_dates)
  end

  def accumulate_streaks(dates, checkins)
    streak, streaks = 0, []
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

  def check_in_dates
    Set.new check_ins.pluck('date').map{ |d| DateHelper.date_in_timezone(d) }
  end

  def checked_in_today?(date_param = DateHelper.date)
    check_ins.where("date >= ? AND date < ?", date_param.to_time.utc, date_param.to_time.utc + 1.day).present?
  end

  def check_in_day?
    scheduler.days.include? DateHelper.wday
  end

  def can_check_in?
    check_in_day? and not checked_in_today?
  end

  def donation_total
    Money.new donations.pluck(:amount_cents).inject(0, :+)
  end

  def sponsors
    contributions.pluck(:name)
  end

  def add_to_reserve_amount amount
    reserve.amount = reserve.amount + Money.new(amount, "USD")
    reserve.save()
  end

  private

  def ensure_wallet
    wallet || create_wallet
  end

  def ensure_reserve
    reserve || create_reserve
  end

  def set_token
    update_attribute(:token, create_token)
  end
end
