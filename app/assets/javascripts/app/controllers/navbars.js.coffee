class App.Controller.Navbars extends Spine.Controller

  constructor: ->
    super
    @render()

  render: ->
    @user_email = user_email()
    $(".navbar").html @view('navbar')(@)