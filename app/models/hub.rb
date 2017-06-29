class Hub < ApplicationRecord

  validates :name, :address_line_1, :postcode, presence: true

  has_many :advisors

  has_many :clients, through: :advisors

  scope :covering_ward, lambda { |code| where('? = ANY (ward_mapit_codes)', code) }
  scope :team_leader, -> { advisors.where(team_leader: true)}

  def address_to_s
    address_to_a.join(", ")
  end

  def address_to_a
    [name, address_line_1, address_line_2, postcode].select{|s| s.present?}
  end

end
