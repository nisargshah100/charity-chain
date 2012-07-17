class GoalsController < ApplicationController
  before_filter :require_login
  
  def new
    @goal_period_options = ['Every day', 'Every weekend', 'Every weekend', 'Every other day']
    @donation_amount_options = []
    (1..20).each { |i| @donation_amount_options << "$#{i}" }
      
    @donation_period_options = ['day', 'week', 'month']
  end
  
  def show
  end
end
