class GoalsController < ApplicationController
  before_filter :require_login
  
  def index
    DonorsChoose.fetch_projects()
  end
end
