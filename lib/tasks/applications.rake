require 'csv'

namespace :applications do
  desc 'Imports applications from old course application format to new applications table. This is needed as was live with course applications for a while.'
  task import_old_course_applications: :environment do
    csv_file = File.open('course_applications.csv', "r:utf-8")
    course_application_csv = CSV.parse(csv_file, headers: true)

    course_application_csv.each do |row|
      application = Application.new(
        first_name: row["first_name"],
        last_name: row["last_name"],
        phone_number: row["phone_number"],
        email: row["email"],
        type: 'CourseApplication',
        statement: nil,
        wordpress_object_id: row["intake_id"],
        dismissed: row["dismissed"],
        created_at: row["created_at"],
        updated_at: row["updated_at"]
      )
      unless application.save
        puts "Application #{application.first_name} #{application.last_name} failed to save: #{application.errors.messages}"
      end
    end

  end
end
