class App.CheckIn extends Spine.Model
  @configure 'CheckIn', 'goal_id', 'date'
  @extend Spine.Model.Ajax
  @url: -> "/api/v1/check_ins?token=#{access_token()}"