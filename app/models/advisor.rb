class Advisor < ApplicationRecord
  # associations
  has_one :login, class_name: UserLogin.to_s, as: :user, dependent: :destroy

  validates :login, :name, presence: true

  delegate :email, to: :login

  belongs_to :hub

  has_many :clients

  scope :by_hub_id, ->(hub_id) { where(hub_id: hub_id) }

  scope :team_leader, ->(hub) { where(hub: hub, team_leader: true) }

  def devise_mailer
    Devise::Mailer
  end
  
  def default_hub_id
    options['show_all_hubs'] == true ? nil : hub_id
  end

  def self.options_for_select(hub_id)
    if hub_id.blank?
      order('LOWER(name)')
    else
      by_hub_id(hub_id).order('LOWER(name)')
    end.map { |e| [e.name, e.id, { 'data-hub-id' => e&.hub&.id }] }
  end
end
