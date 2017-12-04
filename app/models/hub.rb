class Hub < ApplicationRecord
  validates :name, presence: true

  has_many :advisors

  has_many :clients, through: :advisors

  scope :covering_ward, ->(code) { where('? = ANY (ward_mapit_codes)', code) }

  def address_to_s
    address_to_a.join(', ')
  end

  def address_to_a
    [name, address_line_1, address_line_2, postcode].select(&:present?)
  end

  def self.options_for_select
    order('LOWER(name)').map { |e| [e.name, e.id] }
  end

  def team_leader
    advisors.find_by(team_leader: true)
  end
end
