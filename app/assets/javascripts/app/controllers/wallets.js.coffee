class App.Controller.Wallets extends Spine.Controller
  constructor: ->
    super
    @events()

  events: ->
    App.Goal.bind('goal-selected', @render)
    $("#donate-button").live('click', @donate_dialog)
    $("#create-donation").live('click', @create_donation)

  render: =>
    @wallet_amount = goal.wallet_amount.split(".")[0]
    @sponsors_count = goal.sponsors.length
    @donation_total = goal.donation_total.split(".")[0]
    $("#wallet").html @view('wallet')(@)

    $(".modals").append @view('donation_modal')(@)
    $("#donation_modal").modal(show: false)

    if @wallet_amount < 1
      $("#donate-button").addClass('disabled-button').attr('disabled', 'disabled');

  donate_dialog: =>
    @amount = Math.floor(goal.wallet_amount)
    $("#donate-amount").attr('max', @amount).attr('value', @amount)
    $("#range-value").text("$#{@amount}")
    $("#donation_modal").modal('show')

  create_donation: =>
    # donation = new App.Donation({
    #                               goal_id: goal.id,
    #                               project_id: $("#donate-project").val(),
    #                               amount: $("#donate-amount").val()
    #                             })
    # donation.save()

    $.ajax {
      url: "/api/v1/donations",
      type: "POST",
      data: {
        token: access_token(),
        donation: {
          goal_id: goal.id,
          project_id: $("#donate-project").val(),
          amount: $("#donate-amount").val()
        }
      },
      success: (data) =>
        $("#donation_modal").modal('hide')
        App.Goal.fetch()

      error: (data) ->
        response = JSON.parse(data.responseText)
        alert response.join("\n")
    }