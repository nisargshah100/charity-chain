require 'spec_helper'

describe "create a new goal" do
  describe "as a new user" do
    before(:each) do
      visit root_path
    end
    
    it "opens the page", js: true do
      page.should have_content "charity"
      
      page.find("#signup_link").click
      fill_in "user_name", with: "Conan Rimmer"
      fill_in "user_email", with: "conan@lsqa.net"
      fill_in "user_password", with: "password"
      page.find("#signup_submit").click
      
      page.find("#goal-name").visible?.should be_true
      
      fill_in "goal-name", with: "Walk a mile a day"
      page.find("#name_goal_button").click
      
      page.find("#days").visible?.should be_true
      # M W F selected by default; click each of the other days
      page.find(:xpath, "//*[@id='days']//td[1]").click
      page.find(:xpath, "//*[@id='days']//td[3]").click
      page.find(:xpath, "//*[@id='days']//td[5]").click
      page.find(:xpath, "//*[@id='days']//td[7]").click
      page.find("#create_schedule_btn").click

      page.find("#review_goal_name").should have_content "Walk a mile a day"
      page.find("#review_goal_schedule").should have_content "every day"
      
      page.find("#show_sponsor_modal").click
      page.find("#contribute_link").visible?.should be_true
      
      page.find("#contribute_link").value.split("/")[3].should == Goal.last.token
      page.find("#thanks_btn").click
      
      # user name should be in nav bar
      page.find(".user-info").should have_content "Conan Rimmer"
      
      # goal name should be on page
      page.find(".goal-title").should have_content "Walk a mile a day"
    end
  end
end