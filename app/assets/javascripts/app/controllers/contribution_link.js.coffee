class App.Controller.ContributionLink extends Spine.Controller
  constructor: ->
    @events()

  events: ->
    App.Goal.bind('goal-selected', @addLink)

  addLink: ->
    $('.contribution-link').val(goal.contribute_url)