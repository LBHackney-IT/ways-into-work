class Client < ApplicationRecord
  # associations
  has_one :login, class_name: UserLogin.to_s, as: :user, dependent: :destroy

  validates :login, :first_name, :last_name, :phone, :postcode, presence: true

  delegate :email, to: :login

  accepts_nested_attributes_for :login

  validate do
    valid_postcode?
  end

  phony_normalize :phone, default_country_code: 'GB'
  validates_plausible_phone :phone, country_code: 'GB'

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
    false
  end

  def devise_mailer
    CustomDeviseMailer
  end

  def address_to_s
    address_to_a.join(", ")
  end

  def address_to_a
    [address_line_1, address_line_2, postcode].select{|s| s.present?}
  end


end
