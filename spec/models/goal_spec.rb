require 'spec_helper'

describe Goal do
  let!(:datetime) { DateTime.parse("18/6/2012") }
  let!(:goal) { Goal.create(:name => 'Goal One', :created_at => datetime - 11) }
  let!(:schedule) { Scheduler.create(:monday => true, :tuesday => true, :goal => goal) }
  let!(:check_ins) {
    goal.check_ins.create(:date => DateTime.parse("12/6/2012"))
    goal.check_ins.create(:date => DateTime.parse("5/6/2012"))
  }

  it 'counts the proper streak counts' do
    goal.streaks(datetime).should == [1,1]
  end

  
end
