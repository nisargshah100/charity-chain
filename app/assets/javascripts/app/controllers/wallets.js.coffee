class App.Controller.Wallets extends Spine.Controller
  constructor: ->
    super
    $("#donate-modal").modal(show: false);
    @events()

  events: ->
    App.Goal.bind('goal-selected', @render)
    $("#donate-button").live('click', @donate_dialog)

  render: =>
    @wallet = goal.wallet_amount.split(".")[0]
    @sponsors_count = goal.sponsors.length
    @donation_total = goal.donation_total.split(".")[0]
    $("#wallet").html @view('wallet')(@)

    if @wallet < 1
      $("#donate-button").addClass('disabled-button').attr('disabled', 'disabled').html('Need $1 to donate');

  donate_dialog: =>
    $("#donate-modal").modal('show');