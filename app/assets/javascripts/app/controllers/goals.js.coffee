class App.Controller.Goals_New extends Spine.Controller
  constructor: ->
    @render()
    @events()

  events: ->
    $("#name_goal_button").live('click', @show_schedule_form)
    $("#create_schedule_btn").live('click', @show_review_modal)
    $("#show_sponsor_modal").live('click', @show_sponsor_modal)
    $("#thanks_btn").live('click', @hide_all_modals)

    $("td").live('click', @toggle_day)
    App.Goal.bind('refresh', @fetched)
    App.Goal.bind('goal-selected', @displayURL)

  fetched: =>
    # @show()
    @show() if App.Goal.all().length == 0

  displayURL: =>
    $("#contribute_link").val(goal.contribute_url);

  render: ->
    $(".dialogs").append @view('goals/new')(@)
    $(".dialogs").append @view('goals/schedule')(@)
    $(".dialogs").append @view('goals/review')(@)
    $(".dialogs").append @view('goals/sponsor')(@)

    $('#new_goal_modal').modal(show: false);
    $('#schedule_goal_modal').modal(show: false);
    $('#review_goal_modal').modal(show: false);
    $('#sponsor_goal_modal').modal(show: false);

  toggle_day: ->
    if $(this).hasClass('selected')
      $(this).removeClass('selected')
    else
      $(this).addClass('selected') 

  hide_all_modals: =>
    $("#sponsor_goal_modal").modal('hide');

  show_sponsor_modal: =>
    @save()
    $("#review_goal_modal").modal('hide');
    $("#sponsor_goal_modal").modal('show');

  show_schedule_form: =>
    $("#new_goal_modal").modal('hide');
    $("#schedule_goal_modal").modal('show');

  show_review_modal: =>
    $("#review_goal_name").text($("#goal-name").val());

    days = ""
    $("td[data-day][class=selected]").each (index, item) ->
      days += "#{$(item).data('day')} "

    $("#review_goal_schedule").text(days)

    $("#schedule_goal_modal").modal('hide');
    $("#review_goal_modal").modal('show');

  show: ->
    $('#new_goal_modal').modal('show');
    $("#new_goal_modal input").focus();

  hide: ->
    $("#new_goal_modal").modal('hide');

  save: (e) =>
    e.preventDefault() if e

    $.ajax {
      type: 'POST',
      url: '/api/v1/goals.json',
      data: {
        goal: @getFormGoal(),
        scheduler: @getFormDays(),
        token: access_token()
      },
      success: (resp) =>
        @hide()
        $("#alert-bar").addClass('alert-success').text('Congratulations on creating a goal!').hide()
        $("#alert-bar").slideDown().delay(3000).slideUp()
        App.Goal.fetch()
    }

  getFormGoal: ->
    JSON.stringify({
      name: $('#goal-name').val()
    })

  getFormDays: ->
    days = {}
    $(".selected").each ->
      days[$(this).data('day')] = true

    JSON.stringify(days)

class App.Controller.Goals extends Spine.Controller
  constructor: ->
    super
    @new_goal_dialog = new App.Controller.Goals_New()
    App.Goal.fetch()
    @events()

  events: ->
    App.Goal.bind 'refresh', @fetched

  fetched: =>
    window.goal = App.Goal.first()


    if goal
      if App.Project.count() == 0
        for project in goal.project
          Spine.Ajax.disable ->
            App.Project.create(project)
      
      App.Goal.trigger('goal-selected')
      $(".goal-title").text(goal.name)
      @show()

  show: ->
    $("#main-container").removeClass('hide')

