module GoalsHelper
  include ::ActionView::Helpers::UrlHelper
  def contribute_link goal
    contributions_url(token: goal.token)
  end
end