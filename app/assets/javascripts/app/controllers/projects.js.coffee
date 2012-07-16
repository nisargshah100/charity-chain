class App.Controller.Projects extends Spine.Controller
  
  constructor: ->
    super
    @render()

  render: ->
    $("#project").html @view('project')(@)