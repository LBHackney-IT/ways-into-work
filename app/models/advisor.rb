class Advisor < ApplicationRecord
  # associations
  has_one :login, class_name: UserLogin.to_s, as: :user, dependent: :destroy

  validates :login, :name, presence: true

  delegate :email, to: :login

  belongs_to :hub

  has_many :clients

  scope :admins, -> { where(hub_id: nil) }

  scope :team_leader, lambda { |hub| where(hub: hub, team_leader: true) }

  def devise_mailer
    Devise::Mailer
  end

end
