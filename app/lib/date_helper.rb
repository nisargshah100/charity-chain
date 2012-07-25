module DateHelper
  def self.days_hash
    {:sunday => 0, :monday => 1, :tuesday => 2, :wednesday => 3, :thursday => 4, :friday => 5, :saturday => 6}
  end

  def self.now(timezone='Eastern Time (US & Canada)')
    DateTime.now.utc.in_time_zone(timezone)
  end

  def self.date(timezone='Eastern Time (US & Canada)')
    now(timezone).to_date
  end

  def self.wday(timezone='Eastern Time (US & Canada)')
    date(timezone).wday
  end

  def self.wday_in_timezone(datetime, timezone='Eastern Time (US & Canada)')
    datetime.utc.in_time_zone(timezone).wday
  end

  def self.in_timezone(date, timezone='Eastern Time (US & Canada)')
    date.to_time.utc.in_time_zone(timezone)
  end

  def self.date_in_timezone(date, timezone='Eastern Time (US & Canada)')
    in_timezone(date, timezone).to_date
  end
end