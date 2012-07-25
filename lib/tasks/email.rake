task "email:reminder" => :environment do
  User.all.each do |user|
    CheckInMailer.send_reminder(user)
  end

  puts 'Reminders sent'
end