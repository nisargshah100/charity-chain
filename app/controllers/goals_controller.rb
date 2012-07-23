class GoalsController < ApplicationController
  before_filter :require_login
  
  def index
    DonorsChoose.fetch_projects(amount=50, max=10)
  end
end
