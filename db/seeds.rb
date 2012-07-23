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

require 'timecop'
require 'faker'

Timecop.travel(15.days.ago)
test_user = User.create email: "tester@lsqa.net",
                        password: "password"
goal      = test_user.goals.create name: "Walk a mile a day"
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
                            amount: amounts[rand(0..amounts.size-1)],
                            last_four: rand(1..9999).to_s.rjust(4, '0'),
                            card_type: card_types[rand(0..amounts.size-1)]
  contribution.update_attribute :payment, payment
  goal.add_to_reserve_amount payment.amount
end

14.times do
  Timecop.travel(1.day.from_now)
  # check-in
end

Timecop.return