class Scheduler < ActiveRecord::Base
  attr_accessible :sunday, :monday, :tuesday, :wednesday, :thursday, :friday, :saturday, :goal, :created_at
  belongs_to :goal

  # Returns the weekdays in the object's specified periodicity.
  #
  # Example:
  #  scheduler.days
  #  #=> [0,3,5]
  #
  # @return [Array] kind A collection of integers representing the weekdays, e.g. (Monday is 1, Tuesday is 2)

  def days
    days = {:sunday => 0, :monday => 1, :tuesday => 2, :wednesday => 3, :thursday => 4, :friday => 5, :saturday => 6}
    wdays = days.select do |day, wday|
      wday if self.send(day) == true
    end
    wdays.values
  end

  # Returns dates between an end date and the initial check-in date with the object's specified periodicity.
  #
  # Example:
  #  scheduler.generate_dates("21/6/1988")
  #  #=> ["20/6/1988", "18/6/1988", "16/6/1988"]
  #
  # @param [DateTime] end_date The last date in the generated set of dates
  # @return [Array] kind A collection of dates that range from the first check-in to the end_date specified.

  def generate_dates(end_date=DateHelper.now)
    check_in = goal.check_ins.last
    dates = []

    if check_in
      start_date = DateHelper.date_in_timezone(check_in.date)
      prev_date = DateHelper.date_in_timezone(end_date) - 1

      dates = prev_date.downto(start_date).select do |date|
        date if days.include?(date.wday)
      end
    end
    dates.unshift DateHelper.date if goal.checked_in_today?
    dates
  end
end
