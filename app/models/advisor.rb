class Advisor < ApplicationRecord
  # associations
  has_one :login, class_name: UserLogin.to_s, as: :user, dependent: :destroy
  
  validates :login, :name, presence: true
  
  accepts_nested_attributes_for :login

  delegate :email, to: :login

  belongs_to :hub
  has_one :managed_hub, class_name: 'Hub', foreign_key: :manager_id

  has_many :clients, dependent: :nullify
  
  enum role: %i[advisor team_leader admin employer_engagement]

  scope :by_hub_id, ->(hub_id) { where(hub_id: hub_id) }

  scope :team_leader, ->(hub) { where(hub: hub, role: :team_leader) }
  
  before_destroy :nullify_client_reference
  
  def devise_mailer
    CustomDeviseMailer
  end
  
  def default_hub_id
    admin? || employer_engagement? ? nil : hub_id
  end

  def self.options_for_select
    order('LOWER(name)').includes(:hub).map { |e| [e.name, e.id, { 'data-hub-id' => e&.hub&.id }] }
  end
  
  def hackney_works_team?
    advisor? || team_leader?
  end
  
  def root_page
    if hackney_works_team?
      :advisor_my_clients
    else
      :advisor_clients
    end
  end
    
  def send_confirmation!
    login.send :set_reset_password_token
    login.send_reset_password_instructions
  end
  
  def can_assign_to_me?(client)
    return false unless hackney_works_team?
    client.advisor != self
  end
  
  def can_assign?
    team_leader? || admin?
  end
  
  private
  
  def nullify_client_reference
    clients.each do |c|
      c.update_attribute :advisor_id, nil # rubocop:disable Rails/SkipsModelValidations
    end
  end
end
