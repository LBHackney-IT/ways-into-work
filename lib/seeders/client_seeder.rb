
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
    @failures = ''
    @csv_data.each do |row|
      import_client(row)
    end
    puts "@failures #{@failures}"
  end

  def is_number?(obj)
    obj.to_s == obj.to_i.to_s
  end

  def import_client(row)
    # OK for 100 or so clients
    client = Client.find_or_initialize_by(first_name: row['First Name'], last_name: row['Surname'], imported: true)

    puts "importing #{client.name}"
    puts "updating existing record" if client.id
    email = row['Email Address']

    if row['Email Address'].blank?
      @failures << "Not importing #{row['First Name']} #{row['Surname']} without an Email Address\n"
    elsif row['Contact Number'].blank?
      @failures << "Not importing #{row['First Name']} #{row['Surname']} without a Phone Number\n"
    else
      puts "email #{email}"
      begin
        client.tap do |c|
          c.advisor_id = row["Advisor"]
          c.phone = row['Contact Number']
          c.address_line_1 = row['Address line 1']
          c.address_line_2 = row['Address line 2']
          c.postcode = row['Postcode']
          c.login = UserLogin.new(email: email.downcase, password: Devise.friendly_token.first(20)) if c.login.blank?
          # c.funded = row["Claim stream (ESF, FSF, TF, LBH, Other)"].present? && (row["Claim stream (ESF, FSF, TF, LBH, Other)"] != 'LBH')
          c.rag_status = row['Current Status (RAGG)'].try(:downcase) || :un_assessed
          c.gender = row['Gender']
          c.receive_benefits = work_out_boolean(row['Receiving benefits?'])
          c.studying = work_out_boolean(row['Currently studying?'])
          c.employed = work_out_boolean(row['Currently employed?'])
          c.health_conditions = work_out_boolean(row['Any health conditions?'])
          c.affected_by_welfare = work_out_boolean(row['Affected by welfare reform?'])
          c.assessment_notes = generate_assessment_notes(row) if c.assessment_notes.empty?
        end

        # not all have email addresses
        client.save!

        client.update_attribute(:created_at, row['Registration Date']) if row['Registration Date']

      rescue ActiveRecord::RecordInvalid => e
        @failures << "error thrown importing #{client.name} #{e}\n"
        # client.save(validate: false)
      end
    end
  end


  private

  def work_out_boolean(value)
    return if value.blank?
    case value.downcase
    when 'yes'
      true
    when 'no'
      false
    end
  end

  def generate_assessment_notes(row)
    notes = []
    notes << AssessmentNote.new(content_key: 'job_goal_1', content: row['Job Goal 1']) if row['Job Goal 1'].present?
    notes << AssessmentNote.new(content_key: 'job_goal_2', content: row['Job Goal 2']) if row['Job Goal 2'].present?
    notes << AssessmentNote.new(content_key: 'general', content: row['Notes']) if row['Notes'].present?
    notes
  end

  def generate_job_goals(cell)
    return [] if cell.blank?
    job_goals = cell.split(',')
    return [ AssessmentNote.new(content_key: 'job_goal_1', content: job_goals[0]) ] if job_goals.size == 1
    [ AssessmentNote.new(content_key: 'job_goal_1', content: job_goals.shift),
      AssessmentNote.new(content_key: 'job_goal_2', content: job_goals.join(','))
    ]
  end

end
