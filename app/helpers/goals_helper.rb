module GoalsHelper
  def contribute_link goal
    contributions_url(token: goal.token)
  end
end