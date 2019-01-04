class UserLogin < ApplicationRecord
  # Include default devise modules. Others available are:
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :timeoutable

  belongs_to :user, polymorphic: true

  delegate :name, :devise_mailer, :root_page, to: :user

  def generate_default_password
    self.password = Devise.friendly_token.first(20)
  end
end
