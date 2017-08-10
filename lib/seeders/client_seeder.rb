
# This seeding process was wrapped in a class to make it testable
# We have discussed the potential of regulalry updating our services from a remote service
# It is important to make these scripts testable and robust for future use.
class ClientSeeder

  def initialize(filepath)
    @csv_data = begin
      CSV.readlines(filepath, {:headers => :first_row, :encoding => 'UTF-8'})
    rescue Errno::ENOENT
      puts "Didn't find file"
      []
    end
  end

  def import
    @csv_data.each do |row|
      import_client(row)
    end
  end

  def is_number?(obj)
    obj.to_s == obj.to_i.to_s
  end

  def import_client(row)
    # OK for 100 or so clients
    client = Client.find_or_initialize_by(first_name: row['First Name'], last_name: row['Surname'])

    puts "importing #{client.name}"
    puts "updating existing record" if client.id

    if row[:email]
      begin
        client.tap do |c|
          c.advisor_id = row["Advisor"]
          c.phone = row['Contact Number']
          c.postcode = row['Postcode'] || 'N4 2HF'
          c.login = UserLogin.new(email: row['Email Address']) if (row['Email Address'] && c.login.blank?)
          c.funded = row["Claim stream (ESF, FSF, TF, LBH, Other)"]
          c.rag_status = row['Current Status (RAGG)'].try(:downcase) || :un_assessed
          c.assessment_notes = c.assessment_notes.reject{ |goal| goal.content_key == 'job_goal_1' || goal.content_key == 'job_goal_2' }
          c.assessment_notes << generate_job_goals(row['Job Goals'])
        end

        # not all have email addresses
        client.save!

      rescue ActiveRecord::RecordInvalid => e
        puts "\nerror thrown importing #{client.name} #{e}\n"
        client.save(validate: false)
      end
    else
      puts "Not importing #{row['First Name']} #{row['Surname']} without an email address"
    end
  end


  private

  def generate_job_goals(row)
    return [] if row.blank?
    job_goals = row.split(',')
    return [ AssessmentNote.new(content_key: 'job_goal_1', content: job_goals[0]) ] if job_goals.size == 1
    [ AssessmentNote.new(content_key: 'job_goal_1', content: job_goals.shift),
      AssessmentNote.new(content_key: 'job_goal_2', content: job_goals.join(','))
    ]
  end

end
