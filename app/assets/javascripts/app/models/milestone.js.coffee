class App.Milestone extends Spine.Model
  @configure 'Milestone', 'currentStreak'

  milestones: ->
    [1, 5, 10, 20, 30, 90, 150, 210, 360 ]

  currentMilestone: ->
    possibleMilestones = _.select(@milestones(), (x) => x > @currentStreak)
    possibleMilestones[0]

  daysLeft: ->
    @currentMilestone() - @currentStreak

  percentComplete: ->
    percentage = parseFloat(@currentStreak) / parseFloat(@currentMilestone())
    Math.round(percentage * 100)

  completed: ->
    completedMilestone = _.select(@milestones(), (x) => x == @currentStreak)
    if completedMilestone.length > 0 then true else false
