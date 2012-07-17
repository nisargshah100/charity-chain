class App.Goal extends Spine.Model
  @configure 'Goal', 'name', 'days'
  @extend Spine.Model.Ajax
  @url: -> "/api/v1/goals?token=#{access_token()}"