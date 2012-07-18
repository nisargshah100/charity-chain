class Scheduler < ActiveRecord::Base
  attr_accessible :sunday, :monday, :tuesday, :wednesday, :thursday, :friday, :saturday, :goal, :created_at
  belongs_to :goal

  def days
    days = {:sunday => 0, :monday => 1, :tuesday => 2, :wednesday => 3, :thursday => 4, :friday => 5, :saturday => 6}
    wdays = days.select do |day, wday|
      wday if self.send(day) == true
    end
    wdays.values
  end

  def generate_dates(end_date=DateTime.now)
    check_in = goal.check_ins.order('date DESC').last
    dates = []

    if check_in
      start_date = check_in.date.to_date
      prev_date = end_date.to_date - 1

      dates = prev_date.downto(start_date).select do |date|
        date if days.include?(date.wday)
      end
    end

    dates
  end
end
