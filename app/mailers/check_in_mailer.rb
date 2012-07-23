class CheckInMailer < ActionMailer::Base
  default from: "no-reply@charitystreak.herokuapp.com"

  def reminder_email(goal)
    @goal = goal
    mail(:to => goal.user.email, :subject => "#{goal.name} Reminder - CharityStreak")
  end

  def send_reminder(user)
    today = DateTime.now.wday

    for goal in user.goals
      if goal.scheduler.days.include? today and not goal.checked_in_today?
        reminder_email(goal).deliver!
      end
    end
  end
end
