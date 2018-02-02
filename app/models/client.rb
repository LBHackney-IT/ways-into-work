class Client < ApplicationRecord # rubocop:disable ClassLength
  include PgSearch

  acts_as_paranoid

  enum rag_status: %i[un_assessed red amber green]

  # associations
  belongs_to :advisor
  belongs_to :referrer
  has_one :hub, through: :advisor
  has_one :login, class_name: UserLogin.to_s, as: :user, dependent: :destroy, autosave: true

  validates :login, :first_name, :last_name, :phone, :advisor, :postcode, :hub, presence: true

  delegate :email, :email=, to: :login
  delegate :sign_in_count, to: :login

  has_many :meetings
  has_many :achievements

  scope :needing_contact, -> { needing_appointment.order(contact_notes_count: :asc, created_at: :asc) }

  scope :needing_appointment, -> { where(meetings_count: 0, imported: false) }

  scope :with_appointment, -> { where('meetings_count > 0 OR imported = true') }

  scope :with_outcome, ->(outcome, from, to) { where(id: Achievement.with_name(outcome).achieved_in_period(from, to).pluck(:client_id)) }

  accepts_nested_attributes_for :login

  has_many :file_uploads, dependent: :destroy

  has_many :action_plan_tasks

  validate do
    valid_postcode?
  end

  phony_normalize :phone, default_country_code: 'GB'
  validates_plausible_phone :phone, country_code: 'GB'

  has_many :assessment_notes
  has_many :contact_notes

  accepts_nested_attributes_for :assessment_notes, reject_if: :all_blank

  filterrific(
    # default_filter_params: { sorted_by: 'created_at_desc' },
    available_filters: %i[
      search_query
      by_hub_id
      by_types_of_work
      by_advisor_id
      by_training
      by_age
      by_rag_status
      by_objective
      sorted_by
    ]
  )

  scope :by_hub_id, ->(hub_id) { hub_id.blank? ? all : joins(:advisor).where('advisors.hub_id = ?', hub_id) }
  scope :by_advisor_id, ->(advisor_id) { advisor_id.blank? ? all : where(advisor_id: advisor_id) }
  scope :by_types_of_work, ->(type) { where('types_of_work  @> ARRAY[?]::varchar[]', [type]) }
  scope :by_training, ->(type) { where('training_courses  @> ARRAY[?]::varchar[]', [type]) }
  scope :by_funding_code, ->(code) { code.blank? ? all : where('funded @> ARRAY[?]::varchar[]', [code]) }

  scope :by_rag_status, ->(status) { where(rag_status: status) }
  scope :by_objective, ->(objective) { where('objectives @> ARRAY[?]::varchar[]', [objective]) }

  scope :workless_on_benefits, -> { where(receive_benefits: true, employed: true) }
  scope :workless_off_benefits, -> { where(receive_benefits: false, employed: false) }

  scope :under_25, -> { where('date_of_birth > ?', Time.zone.today - 25.years) }
  scope :over_50, -> { where('date_of_birth < ?', Time.zone.today - 50.years) }
  scope :care_leavers, -> { where(care_leaver: 'Yes') }
  scope :health_conditions, -> { where(health_condition: 'Yes') }
  scope :female, -> { where(gender: 'Female') }
  scope :bame, -> { where('bame != ?', 'white_british') }

  scope :by_age, lambda { |under_25s|
    where('date_of_birth  > ?', Time.zone.today - 25.years) if under_25s
  }

  pg_search_scope :search_query, against: %i[first_name last_name], using: {
    trigram: {
      threshold: 0.1
    }
  }

  scope :sorted_by, lambda { |sort_options|
    direction = sort_options.match?(/desc$/) ? 'desc' : 'asc'
    case sort_options.to_s
    when /^first_name/
      order("first_name #{direction}")
    when /^advisor/
      joins(:advisor).order("advisors.name #{direction}")
    when /^rag_status/
      order("(rag_status=0, rag_status=1, rag_status=2, rag_status=3) #{direction}")
    when /^next_meeting_date/
      order("next_meeting_date #{direction}")
    end
  }

  def self.csv(clients)
    CSV.generate do |csv|
      csv << csv_header
      clients.each do |c|
        csv << c.csv_row
      end
    end
  end

  def self.csv_header # rubocop:disable Rails/MethodLength
    [
      'Registation date',
      'Advisor Name',
      'Client Name',
      'Email',
      'Funding Code',
      'Types of Work Interested In',
      'RAG Rating',
      'Industry Preference',
      'Ethnicity',
      'Gender',
      'Date of birth',
      'Affected by Beneft Cap?',
      'Assigned to Supported Employment?',
      'Health Condition or Disability?',
      'Claiming Benefits?',
      'Care leaver?',
      'Referrer Email',
      AchievementOption.all.map(&:name)
    ].flatten
  end

  def self.registered_on(from, to = nil)
    if to.nil?
      from = from.beginning_of_month
      to = from.end_of_month
    end
    where('created_at BETWEEN ? AND ?', from, to)
  end

  def last_meeting_or_contact
    last_communication_events.max.to_date.to_s(:long) if last_communication_events.any?
  end

  def upcoming_meetings
    @upcoming_meetings ||= meetings.where('meetings.start_datetime > ?', Time.zone.now).order(:start_datetime)
  end

  def last_communication_events
    @past_contacts ||= meetings.where('meetings.start_datetime < ?', Time.zone.now).pluck(:start_datetime) +
                       contact_notes.where('contact_notes.created_at < ?', Time.zone.now).pluck(:created_at)
  end

  def name
    "#{first_name} #{last_name}"
  end

  def valid_postcode?
    if better_postcode = GoingPostal.postcode?(postcode, 'GB')
      self.postcode = better_postcode
    else
      errors[:postcode] << I18n.t('clients.validation.postcode_error')
      false
    end
  end

  def devise_mailer
    CustomDeviseMailer
  end

  def phone_number
    phone.phony_formatted
  end

  def address_to_s
    address_to_a.join(', ')
  end

  def address_to_a
    [address_line_1, address_line_2, postcode].select(&:present?)
  end

  def age_in_years
    @age ||= (DateTime.current.mjd - date_of_birth.to_date.mjd) / 365 if date_of_birth
  end

  def root_page
    :client_dashboard
  end

  def csv_row # rubocop:disable Rails/MethodLength, Metrics/AbcSize
    [
      created_at.to_date,
      advisor.name,
      name,
      login.email,
      funded.join(', '),
      objectives.join(', '),
      rag_status,
      types_of_work.join(', '),
      ethnicity,
      gender,
      date_of_birth&.to_date,
      affected_by_benefit_cap?.humanize,
      assigned_supported_employment?.humanize,
      health_condition,
      receive_benefits?.humanize,
      care_leaver,
      referrer&.email,
      achievement_counts
    ].flatten
  end

  def achievement_counts
    AchievementOption.all.map do |option|
      achievements.select { |a| a.name == option.id }.count
    end
  end

  def ethnicity
    other_bame || BameOption.find(bame)&.name
  end

  def assign_team_leader(ward_mapit_code)
    self.advisor = Advisor.team_leader(Hub.covering_ward(ward_mapit_code)).first ||
                   Advisor.find_by(role: :team_leader)
  end

  def assign_advisor(advisor_id, current_advisor)
    if advisor = Advisor.find(advisor_id)
      update_advisor(advisor, current_advisor)
    else
      false
    end
  end

  def update_advisor(advisor, current_advisor)
    update_attribute(:advisor, advisor) # rubocop:disable Rails/SkipsModelValidations
    AdvisorMailer.notify_assigned(self).deliver_now unless current_advisor == advisor
  end

  def assign_area(postcode)
    return if postcode.blank?
    if ward_mapit_code = HackneyWardFinder.new(postcode).lookup
      assign_team_leader(ward_mapit_code)
      login.generate_default_password
    else
      false
    end
  end

  def completed_education?
    training_courses.any? || !studying.nil?
  end

  def completed_objectives?
    objectives.any? || types_of_work.any? || support_priorities.any?
  end

  def completed_about_you?
    personal_traits.any?
  end

  def send_emails
    login.send_reset_password_instructions
    AdvisorMailer.notify_client_signed_up(self).deliver_now
  end

  def generate_initial_meeting
    meetings.create(
      start_datetime: Time.zone.now,
      advisor: advisor,
      client_attended: true,
      agenda: 'initial_assessment'
    )
  end
end
