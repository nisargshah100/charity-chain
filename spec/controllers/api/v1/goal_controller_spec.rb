require 'spec_helper'

describe Api::V1::GoalsController, :type => :controller do

  let!(:user) { User.create(:email => 'one@one.com', :password => 'oneone', :name => 'One Man')}
  let!(:my_goal) { Goal.create(:name => 'Goal 1', :user => user) }
  let!(:goal) { Goal.create(:name => 'Goal 2') }

  let!(:schedulers) { [my_goal, goal].each { |g| Scheduler.create(:goal => g) }}

  context 'unauthenticated' do
    it 'returns false' do
      visit api_v1_goals_path
      page.should have_content('false')
    end

    it 'creates a goal' do
      visit api_v1_goals_path
      page.should have_content('false')
    end
  end

  context 'authenticated' do
    context '#index' do
      before(:each) do
        visit api_v1_goals_path(:token => user.authentication_token)
      end

      it 'returns empty goals' do
        page.should have_content('[]')
      end

      it 'returns my goals' do
        page.should have_content('Goal 1')
        page.should_not have_content('Goal 2')
      end
    end

    context '#create' do
      pending 'to do!'
    end
  end
end