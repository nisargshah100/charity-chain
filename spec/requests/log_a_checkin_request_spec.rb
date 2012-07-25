require 'spec_helper'

describe "log a check-in" do
  let!(:goal)       { FactoryGirl.create :goal }
  let!(:user)       { FactoryGirl.create :user }
  let!(:scheduler)  { FactoryGirl.create :scheduler }
  let!(:project)    { FactoryGirl.create :project }
  
  before(:each) do
    user.goals << goal
    goal.scheduler = scheduler
    goal.save
    visit root_path
    page.find("#signin_link").click
    fill_in "signin_email", with: user.email
    fill_in "signin_password", with: "password"
    page.find("#signin_submit").click
  end
  
  it "registers a checkin for a given goal", js:true do
    page.find("#streak-length").text.should == "0"
    page.find("#dollars-earned").text.should == "0"
    page.find("#check-in-button").click
    wait_until(10) do
      page.find("#streak-length").text == "1"
    end
    page.find("#dollars-earned").text.should == "1"
  end
end