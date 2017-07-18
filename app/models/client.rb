class Client < ApplicationRecord

  include PgSearch

  enum rag_status: [ :un_assessed, :red, :amber, :green ]
  enum unemployed_status: [ :unknown, :less_than_1year, :over_1year, :never_worked ]

  # associations
  belongs_to :advisor
  has_one :hub, through: :advisor
  has_one :login, class_name: UserLogin.to_s, as: :user, dependent: :destroy

  validates :login, :first_name, :last_name, :phone, :date_of_birth, :postcode, :advisor, :hub, presence: true

  delegate :email, to: :login

  has_many :meetings

  scope :needing_contact, -> { needing_appointment.where('contact_notes_count < 3 ').order(contact_notes_count: :asc, created_at: :asc) }

  scope :needing_appointment, -> { where(meetings_count: 0) }

  scope :with_appointment, -> { where('meetings_count > 0 OR contact_notes_count > 3') }

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
    available_filters: [
      :search_query,
      :by_hub_id,
      :by_types_of_work,
      :by_advisor_id,
      :by_training,
      :by_age,
    ]
  )

  scope :by_hub_id, lambda { |hub_id| joins(:advisor).where('advisors.hub_id = ?', hub_id ) }
  scope :by_advisor_id, lambda { |advisor_id| where(advisor_id: advisor_id ) }
  scope :by_types_of_work, lambda { |type| where('types_of_work  @> ARRAY[?]::varchar[]', [type]) }
  scope :by_training, lambda { |type| where('training_courses  @> ARRAY[?]::varchar[]', [type]) }

  scope :by_age, lambda { |under_25s|
    where('date_of_birth  > ?', Date.today - 25.years) if under_25s
  }

  pg_search_scope :search_query, :against => [:first_name, :last_name]

  def name
   "#{first_name} #{last_name}"
  end

  def valid_postcode?
    return false if self.postcode.blank?
    if better_postcode = GoingPostal.postcode?(postcode, 'GB')
      self.postcode = better_postcode
    else
      errors[:postcode] << I18n.t('clients.validation.postcode_error')
    end
    errors[:postcode].empty?
  end

  def profile_complete?
    !self.un_assessed?
  end

  def devise_mailer
    CustomDeviseMailer
  end

  def phone_number
    self.phone.phony_formatted
  end

  def address_to_s
    address_to_a.join(", ")
  end

  def address_to_a
    [address_line_1, address_line_2, postcode].select{|s| s.present?}
  end

  def age_in_years
    @age ||= (DateTime.now.mjd - date_of_birth.to_date.mjd)/365 if date_of_birth
  end

  def assign_team_leader(ward_mapit_code)
    self.advisor = Advisor.team_leader(Hub.covering_ward(ward_mapit_code)).first
  end

end
