class App.Donation extends Spine.Model
  @configure 'Donation', 'project_id', 'amount', 'goal_id'
  @extend Spine.Model.Ajax
  @url: -> "/api/v1/donations?token=#{access_token()}"
