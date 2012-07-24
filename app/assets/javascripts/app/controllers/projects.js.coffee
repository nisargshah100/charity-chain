class App.Controller.Projects extends Spine.Controller
  
  constructor: ->
    super
    @events()

  events: ->
    App.Goal.bind('goal-selected', @render)
    App.Goal.bind('goal-selected', @renderButtons)
    $(".donate-button-small").live('click', @donateDialog)
    $("#create-donation").live('click', @createDonation)
    $("").live('click', @createDonation)

  donateDialog: ->
    @amount = Math.floor(goal.wallet_amount)
    @id = $(this).data('id')
    @project = App.Project.find(@id)

    $("#donate-amount").attr('max', @amount).attr('value', @amount)
    $("#range-value").text("$#{@amount}")
    $("#donation_modal").modal('show')

    $('#project-title').html(@project.title)
    $('#project-school').html(@project.schoolName)
    $('#project-location').html("#{@project.city}, #{@project.state}")
    $("#donate-project-id").val(@id)
    $("#project-image-tag").attr('src', @project.imageURL)

  createDonation: =>
    $.ajax {
      url: "/api/v1/donations",
      type: "POST",
      data: {
        token: access_token(),
        donation: {
          goal_id: goal.id,
          project_id: $("#donate-project-id").val(),
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

  render: =>
    $("#project").html @view('project')(@) unless $("#project").html().trim()
    $(".modals").append @view('donation_modal')(@)
    $("#donation_modal").modal(show: false)
    
  renderButtons: =>
    if goal.wallet_amount < 1 || goal.reserve_amount < 1
      $(".donate-button-small").addClass('disabled-button').attr('disabled', 'disabled')
    else
      $(".donate-button-small").removeClass('disabled-button').removeAttr('disabled')