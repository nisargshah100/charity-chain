require 'spec_helper'

describe 'contribution new page' do
  let!(:goal)       { FactoryGirl.create :goal }
  let!(:user)       { FactoryGirl.create :user }
  let!(:scheduler)  { FactoryGirl.create :scheduler }
  let!(:project)    { FactoryGirl.create :project }
  
  before(:each) do
    user.goals << goal
    goal.scheduler = scheduler
    goal.save
    visit contributions_path id: goal.token
  end
  
  it "takes the user to the contributions create page" do
    URI.parse(current_url).path.should == contributions_path
  end
  
  it "displays the goal's owner name in the description text" do
    page.find(".owner_name").should have_content user.name
  end
  
  it "displays the goal name in the description text" do
    page.find(".goal_name").should have_content goal.name
  end
end