class App.Controller.Streaks extends Spine.Controller
  constructor: ->
    super
    @events()

  events: ->
    $("#check-in-button").live('click', @checkIn)
    App.CheckIn.bind('create', @updateStreak)
    App.Goal.bind('goal-selected', @render)

  render: =>
    @computeStats()
    $("#streak").html @view('streak')(@)

    unless goal.can_check_in
      $("#check-in-button").addClass('disabled-button').attr('disabled', true);

  computeStats: ->
    if goal.streaks
      @current_streak = goal.streaks[0]
      @longest_streak = _.max(goal.streaks)
      @average_streak = Math.round (@sum(goal.streaks) / goal.streaks.length)
    else
      @current_streak = @longest_streak = @average_streak = 0

  sum: (streaks) =>
    total = 0
    $.each streaks, -> total += this
    total

  checkIn: =>
    check_in = new App.CheckIn(goal_id: goal.id, date: new Date())
    check_in.save()
    App.Goal.fetch()

  updateStreak: (btn) ->
    $("#streak-length").fadeOut(200, -> $(this).html(@current_streak)).fadeIn(200);
    $("#check-in-button").addClass('disabled-button').attr('disabled', true);