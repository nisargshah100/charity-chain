module ContributionsHelper
  def display_contribution_amount amount
    "$#{amount / 100}"
  end
end