# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

amounts     = [1000,2500,5000]
card_types  = ["Visa","Mastercard","Discover","Amex"]

User.destroy_all
Goal.destroy_all
Scheduler.destroy_all
Contribution.destroy_all
Payment.destroy_all
CheckIn.destroy_all

require 'timecop'
require 'faker'

emails = ["nisarg.shah@charitystreak.com", "jan.koszewski@charitystreak.com", "mike.silvis@charitystreak.com", "michael.verdi@charitystreak.com", "tom.kiefhaber@charitystreak.com", "michael.chlipala@charitystreak.com", "jonan.scheffler@charitystreak.com", "conan.rimmer@charitystreak.com", "mark.tabler@charitystreak.com", "travis.valentine@charitystreak.com", "austen.ito@charitystreak.com", "andrew.thal@charitystreak.com", "edward.weng@charitystreak.com", "jeff.casimir@charitystreak.com", "charles.strahan@charitystreak.com", "matt.yoho@charitystreak.com", "elise.worthy@charitystreak.com", "christopher.maddox@charitystreak.com", "jacqueline.chenault@charitystreak.com", "mary.cutrali@charitystreak.com", "cindy.couchman@charitystreak.com", "andrew.glass@charitystreak.com", "daniel.kaufman@charitystreak.com", "melanie.gilman@charitystreak.com", "horace.williams@charitystreak.com", "darrell.rivera@charitystreak.com", "christopher.anderson@charitystreak.com", "chad.fowler@charitystreak.com"]

sample_goals = ["Walk one mile", "Jog two miles", "Bike for 5 miles", "Exercise for 30 minutes", "Not eat junk food", "Not eat out", "Read for one hour", "Practice French for one hour", "Write a blog post", "Spend one hour on an open source project"]

emails.each do |email|
  Timecop.travel(25.days.ago)
  test_user = User.create name: email.gsub("@charitystreak.com","").split(".").join(" "),
                          email: email,
                          password: "password"
  goal      = test_user.goals.create name: sample_goals[rand(sample_goals.size)]
  schedule  = Scheduler.create goal: goal,
                              sunday: true,
                              monday: true,
                              tuesday: true,
                              wednesday: true,
                              thursday: true,
                              friday: true,
                              saturday: true
  4.times do
    contribution = goal.contributions.create name: Faker::Name.name
    payment = Payment.create  contribution: contribution,
                              amount: amounts[rand(amounts.size)],
                              last_four: (rand(9999) + 1).to_s.rjust(4, '0'),
                              card_type: card_types[rand(amounts.size)]
    contribution.update_attribute :payment, payment
    goal.add_to_reserve_amount payment.amount
  end

  15.times do
    goal.check_ins.create date: Time.now
    Timecop.travel(1.day.from_now)
  end

  Timecop.travel(5.days.from_now)   # took 5 days off

  5.times do
    goal.check_ins.create date: Time.now
    Timecop.travel(1.day.from_now)
  end

  Timecop.return
end