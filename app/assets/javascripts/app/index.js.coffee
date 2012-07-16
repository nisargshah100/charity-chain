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

class App extends Spine.Controller
  constructor: ->
    super

    @append(new App.Controller.Navbars)
    @append(new App.Controller.Streaks)
    @append(new App.Controller.Wallets)
    @append(new App.Controller.Projects)
    
    Spine.Route.setup()    

window.App = App
window.App.Controller = {}