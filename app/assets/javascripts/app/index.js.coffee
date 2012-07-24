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
    @append(new App.Controller.ContributionLink)
    
    Spine.Route.setup()  

window.App = App
window.App.Controller = {}

window.user_email = ->
  $('.user-meta').data('email')

window.access_token = ->
  $('.user-meta').data('token')

window.current_goal = ->
  $('.user-meta').data('goal_id')


window.render_partial = ( path, options = {} ) ->
    # add the leading underscore (like rails-partials)
    path = path.split('/')
    path[ path.length - 1 ] = '_' + path[ path.length - 1 ]
    path = path.join('/')
    # render and return the partial if existing
    try
        JST["app/views/#{ path }"]( options )
    catch error
        # if App.Environment != 'production' then "<p class='error'>Sorry, there is no partial named '#{ path }'.</p>" else ''
        "<p class='error'>Sorry, there is no partial named '#{ path }'.</p>"