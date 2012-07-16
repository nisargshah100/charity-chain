class App.Controller.Wallets extends Spine.Controller
  constructor: ->
    super
    @render()

  render: ->
    $("#wallet").html @view('wallet')(@)