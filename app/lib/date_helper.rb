module DateHelper
  def self.now(timezone='Eastern Time (US & Canada)')
    DateTime.now.utc.in_time_zone(timezone)
  end
end