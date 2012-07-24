require 'spec_helper'

describe Api::V1::GoalsController do

  let!(:user) { User.create(:email => 'one@one.com', :password => 'oneone', :name => 'One Man')}

  context 'unauthenticated' do
    it 'returns false' do
      visit api_v1_goals_path
      page.should have_content('false')
    end
  end

  context 'authenticated' do
    # before(:each) do
    #   # login_user('one@one.com', 'oneone')
    #   post sessions_path, { email: 'one@one.com', password: 'oneone' }
    # end

    # it 'returns the goals' do
    #   visit api_v1_goals_path
    #   page.should have_content('Goal 1')
    # end
  end
end