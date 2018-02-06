namespace :meeting_reminder do
  desc 'Sends sms reminders using Gov notify.'
  namespace :sms do
    desc 'Sends two hours before meeting is scheduled'
    task two_hours_before: :environment do
      response = SmsReminderService.new(:two_hours_from_now, Meeting.two_hours_from_now).perform
      puts "response #{response}"
    end

    desc 'Sends two days before meeting is scheduled'
    task two_days_before: :environment do
      response = SmsReminderService.new(:two_days_from_now, Meeting.two_days_from_now).perform
      puts "response #{response}"
    end
  end
end
