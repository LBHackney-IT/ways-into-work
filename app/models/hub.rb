class Hub < ApplicationRecord

  validates :name, :address_line_1, :postcode, presence: true

  has_many :advisors
  has_one :service_manager

  scope :covering_ward, lambda { |code| where('? = ANY (ward_mapit_codes)', code) }

  after_validation :geocode
  geocoded_by :address_to_s

  def address_to_s
    address_to_a.join(", ")
  end

  def address_to_a
    [name, address_line_1, address_line_2, postcode].select{|s| s.present?}
  end

end
