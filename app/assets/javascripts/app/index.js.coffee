#= require json2
#= require jquery
#= require spine
#= require spine/manager
#= require spine/ajax
#= require spine/route

#= require_tree ./lib
#= require_self

#= require_tree ./models
#= require_tree ./controllers
#= require_tree ./views

Spine.Model.host = "/api/v1";

$(document).ajaxError (e, xhr) ->
  if xhr.status == 403
    alert 'You may have been logged out or you dont have the access to do that.'

class App extends Spine.Controller
  constructor: ->
    super

    @append(new App.Controller.Navbars)
    @append(new App.Controller.Streaks)
    @append(new App.Controller.Wallets)
    @append(new App.Controller.Projects)
    @append(new App.Controller.Goals)
    
    Spine.Route.setup()  

window.App = App
window.App.Controller = {}

window.access_token = ->
  $('.user-meta').data('token')

window.current_goal = ->
  $('.user-meta').data('goal_id')