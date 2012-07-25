module DateHelper
  DEFAULT_TIMEZONE = 'Eastern Time (US & Canada)'
  def self.days_hash
    {:sunday => 0, :monday => 1, :tuesday => 2, :wednesday => 3, :thursday => 4, :friday => 5, :saturday => 6}
  end

  def self.now(timezone=DEFAULT_TIMEZONE)
    DateTime.now.utc.in_time_zone(timezone)
  end

  def self.date(timezone=DEFAULT_TIMEZONE)
    now(timezone).to_date
  end

  def self.wday(timezone=DEFAULT_TIMEZONE)
    date(timezone).wday
  end

  def self.wday_in_timezone(datetime, timezone=DEFAULT_TIMEZONE)
    datetime.utc.in_time_zone(timezone).wday
  end

  def self.in_timezone(date, timezone=DEFAULT_TIMEZONE)
    date.to_time.utc.in_time_zone(timezone)
  end

  def self.date_in_timezone(date, timezone=DEFAULT_TIMEZONE)
    in_timezone(date, timezone).to_date
  end
end
