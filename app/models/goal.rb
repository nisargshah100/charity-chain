class Goal < ActiveRecord::Base
  attr_accessible :check_in_interval, :name, :reserve_amount_cents, :user_id, :wallet_amount_cents, :user, :created_at
  belongs_to :user
  has_many :check_ins
  has_one :scheduler

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
end
