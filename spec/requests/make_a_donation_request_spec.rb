require 'spec_helper'

describe "make a donation" do
  let!(:goal)       { FactoryGirl.create :goal }
  let!(:user)       { FactoryGirl.create :user }
  let!(:scheduler)  { FactoryGirl.create :scheduler }
  let!(:project)    { FactoryGirl.create :project }
  
  before(:each) do
    user.goals << goal
    goal.scheduler = scheduler
    goal.save
    goal.wallet.update_attribute(:amount_cents, 2500)
    goal.reserve.update_attribute(:amount_cents, 12500)
    visit root_path
    page.find("#signin_link").click
    fill_in "signin_email", with: user.email
    fill_in "signin_password", with: "password"
    page.find("#signin_submit").click
  end
  
  it "registers a donation to a given project", js:true do
    page.find("#dollars-earned").text.should == "25"
    page.find(".reserve-amount").should have_content "$125"
    page.find(".donate-button-small").click
    page.find("#create-donation").click
    wait_until(10) do
      !page.find("#create-donation").visible?
    end
    page.find("#all-done").click
    wait_until(10) do
      !page.find("#all-done").visible?
    end    
    page.find("#dollars-earned").text.should == "0"
    page.find(".reserve-amount").should have_content "$100"
  end
end