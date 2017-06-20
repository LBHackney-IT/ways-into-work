class Advisor < ApplicationRecord
  # associations
  has_one :login, class_name: UserLogin.to_s, as: :user, dependent: :destroy

  validates :login, :name, presence: true

  belongs_to :hub

  has_many :clients


  def devise_mailer
    Devise::Mailer
  end

end
