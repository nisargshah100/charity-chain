class CheckIn < ActiveRecord::Base
  attr_accessible :goal_id, :date
  belongs_to :goal
  default_scope :order => 'date DESC'

  after_create :increase_wallet
  validate :no_checkin_for_today

  def no_checkin_for_today
    today = DateHelper.wday
    if (not goal.scheduler.days.include? today) || goal.checked_in_today?
      errors.add(:date, "Already checked in today or not in schedule.")
    end
  end

  private

  def increase_wallet
    self.goal.wallet.increase
  end
end
