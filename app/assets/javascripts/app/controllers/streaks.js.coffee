class App.Controller.Streaks extends Spine.Controller

  constructor: ->
    super
    @render()
    @events()

  events: ->
    $("#check-in-button").live('click', @checkIn)
    App.CheckIn.bind('create', @updateStreak)

  render: ->
    $("#streak").html @view('streak')(@)

  checkIn: =>
    check_in = new App.CheckIn(goal_id: 1)
    check_in.save()

  updateStreak: (btn) ->
    $("#streak-length").fadeOut(200, -> $(this).html("21")).fadeIn(200);
    $("#dollars-earned").fadeOut(200, -> $(this).html("91")).fadeIn(200);
    $("#longest-streak-length").html("21");
    $("#check-in-button").addClass('disabled-button').attr('disabled', true);