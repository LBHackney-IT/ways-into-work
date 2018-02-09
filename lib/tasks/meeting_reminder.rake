namespace :meeting_reminder do
  desc 'Sends sms reminders using Gov notify.'
  namespace :sms do
    desc 'Sends meeting reminder the day before'
    task day_before: :environment do
      response = SmsReminderService.new(Meeting.occurring_tomorrow).perform
      puts "response #{response}"
    end
  end
end
