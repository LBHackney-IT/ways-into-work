class Client < ApplicationRecord
  include PgSearch

  acts_as_paranoid

  enum rag_status: %i[un_assessed red amber green]

  # associations
  belongs_to :advisor
  has_one :hub, through: :advisor
  has_one :login, class_name: UserLogin.to_s, as: :user, dependent: :destroy

  validates :login, :first_name, :last_name, :phone, :advisor, :postcode, :hub, presence: true

  delegate :email, to: :login
  delegate :sign_in_count, to: :login

  has_many :meetings

  scope :needing_contact, -> { needing_appointment.order(contact_notes_count: :asc, created_at: :asc) }

  scope :needing_appointment, -> { where(meetings_count: 0, imported: false) }

  scope :with_appointment, -> { where('meetings_count > 0 OR imported = true') }

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
    ]
  )

  scope :by_hub_id, ->(hub_id) { joins(:advisor).where('advisors.hub_id = ?', hub_id) }
  scope :by_advisor_id, ->(advisor_id) { where(advisor_id: advisor_id) }
  scope :by_types_of_work, ->(type) { where('types_of_work  @> ARRAY[?]::varchar[]', [type]) }
  scope :by_training, ->(type) { where('training_courses  @> ARRAY[?]::varchar[]', [type]) }

  scope :by_age, lambda { |under_25s|
    where('date_of_birth  > ?', Time.zone.today - 25.years) if under_25s
  }

  pg_search_scope :search_query, against: %i[first_name last_name], using: {
    trigram: {
      threshold: 0.1
    }
  }

  def next_meeting_date
    upcoming_meetings.first.start_datetime.to_date.to_s(:long) if upcoming_meetings.any?
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
    return false if postcode.blank?
    if better_postcode = GoingPostal.postcode?(postcode, 'GB')
      self.postcode = better_postcode
    else
      errors[:postcode] << I18n.t('clients.validation.postcode_error')
    end
    errors[:postcode].empty?
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

  def assign_team_leader(ward_mapit_code)
    self.advisor = Advisor.team_leader(Hub.covering_ward(ward_mapit_code)).first ||
                   Advisor.where(team_leader: true).first
  end
end
