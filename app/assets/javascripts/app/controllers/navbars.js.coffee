class App.Controller.Navbars extends Spine.Controller

  constructor: ->
    super
    @render()

  render: ->
    $(".navbar").html @view('navbar')(@)