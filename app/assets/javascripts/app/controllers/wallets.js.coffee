class App.Controller.Wallets extends Spine.Controller
  constructor: ->
    super
    @events()

  events: ->
    App.Goal.bind('goal-selected', @render)

  render: =>
    console.log goal
    @wallet = goal.wallet_amount.split(".")[0]
    @sponsors_count = goal.sponsors.length
    @donation_total = goal.donation_total.split(".")[0]
    $("#wallet").html @view('wallet')(@)