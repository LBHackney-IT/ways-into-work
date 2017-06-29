class Client < ApplicationRecord
  # associations
  belongs_to :advisor
  has_one :hub, through: :advisor
  has_one :login, class_name: UserLogin.to_s, as: :user, dependent: :destroy

  validates :login, :first_name, :last_name, :phone, :date_of_birth, :postcode, :advisor, :hub, presence: true

  delegate :email, to: :login

  has_many :meetings

  scope :needing_appointment, -> { where(meetings_count: 0) }
  scope :with_appointment, -> { where('meetings_count > 0') }

  accepts_nested_attributes_for :login

  validate do
    valid_postcode?
  end

  phony_normalize :phone, default_country_code: 'GB'
  validates_plausible_phone :phone, country_code: 'GB'

  def name
   "#{first_name} #{last_name}"
  end

  def age
    now = Time.now.utc.to_date
    now.year - date_of_birth.year - ((now.month > date_of_birth.month || (now.month == date_of_birth.month && now.day >= date_of_birth.day)) ? 0 : 1)
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
    false
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
