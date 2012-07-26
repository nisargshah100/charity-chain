require 'spec_helper'

describe 'contribution show page' do
  let!(:goal)       { FactoryGirl.create :goal }
  let!(:user)       { FactoryGirl.create :user }
  let!(:scheduler)  { FactoryGirl.create :scheduler }
  let!(:project)    { FactoryGirl.create :project }
  let!(:contribution) { FactoryGirl.create :contribution }
  let!(:payment)    { FactoryGirl.create :payment }
  
  before(:each) do
    user.goals << goal
    goal.scheduler = scheduler
    goal.contributions << contribution
    goal.save
    contribution.payment = payment
    contribution.save
    visit contribution_path contribution
  end
  
  it "takes the user to the contributions create page" do
    URI.parse(current_url).path.should == contribution_path(contribution)
  end
  
  it "displays the name of the cardholder charged" do
    page.find(".charged-to").should have_content "Paula Brewman"
  end
  
  it "it displays the amount charged" do
    page.find(".amount").should have_content "$10"
  end
end