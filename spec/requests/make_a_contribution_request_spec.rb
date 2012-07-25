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
  
  it "takes the user to the contributions create page", js:true do
    select "40", from: "amount"
    fill_in "cardholder_name", with: "Paula Brewman"
    fill_in "card_number", with: "4242-4242-4242-4242"
    select "5", from: "card_expiration_month"
    select "2015", from: "card_expiration_year"
    fill_in "card_sec_code", with: "432"
    page.find("#contribute_button").click
    page.find(".charged-to").should have_content "Paula Brewman"
    page.find(".amount").should have_content "$40"
  end
end