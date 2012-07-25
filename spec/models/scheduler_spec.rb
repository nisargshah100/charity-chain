require 'spec_helper'

describe Scheduler do
  let!(:datetime) { DateTime.parse("18/6/2012") }
  let!(:goal) { Goal.create(:name => 'Goal One', :created_at => datetime - 11) }
  let!(:schedule) { Scheduler.create(:monday => true, :tuesday => true, :goal => goal) }

  let!(:check_ins) {
    10.downto(1) { |i| goal.check_ins.create(:date => datetime - i) }
  }

  it 'generates proper dates length' do
    schedule.generate_dates(datetime).count.should == 0
  end

  it 'generates the proper dates' do
    dates = schedule.generate_dates(datetime)
    dates.should == []
    # [Date.parse("11/6/2012"), Date.parse("12/6/2012")].each do |date|
    #   dates.should include(date)
    # end
  end
end
