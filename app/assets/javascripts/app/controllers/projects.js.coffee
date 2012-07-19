class App.Controller.Projects extends Spine.Controller
  
  constructor: ->
    super
    @events()

  events: ->
    App.Goal.bind('goal-selected', @render)

  render: =>
    $("#project").html @view('project')(@)