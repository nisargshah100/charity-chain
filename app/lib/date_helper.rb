module DateHelper
  def self.now(timezone='Eastern Time (US & Canada)')
    DateTime.now.utc.in_time_zone(timezone)
  end

  def self.date(timezone='Eastern Time (US & Canada)')
    now(timezone).to_date
  end

  def self.wday(timezone='Eastern Time (US & Canada)')
    date(timezone).wday
  end

  def self.in_timezone(date, timezone='Eastern Time (US & Canada)')
    date(timezone)
  end

  def self.date_in_timezone(date, timezone='Eastern Time (US & Canada)')
    in_timezone(timezone).to_date
  end
end