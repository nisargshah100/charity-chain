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
    @computeMilestone()
    @showFlash = false

    $("#streak").html @view('streak')(@)
    if not goal.check_in_day or goal.checked_in_today
      message = if not goal.check_in_day then "Off Day!" else "Nice!"
      $("#check-in-button").attr('disabled', true).html(message)

  computeMilestone: (flash) ->
    @milestone = new App.Milestone(currentStreak: @current_streak)
    @showMilestoneFlash() if @showFlash

  showMilestoneFlash: ->
    if @milestone.completed()
      $("#alert-bar").addClass('alert-success').text('You just hit a milestone! Way to go!').hide()
      $("#alert-bar").slideDown().delay(3000).slideUp()

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
    checkin = App.CheckIn.create(goal_id: goal.id, date: new Date())
    checkin.bind "ajaxSuccess", (status, xhr) => App.Goal.fetch()
    @showFlash = true

  updateStreak: (btn) ->
    $("#streak-length").fadeOut(200, -> $(this).html(@current_streak)).fadeIn(200);
    $("#check-in-button").addClass('disabled-button').attr('disabled', true);