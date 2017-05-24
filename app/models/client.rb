class Client < ApplicationRecord
  # associations
  has_one :login, class_name: UserLogin.to_s, as: :user, dependent: :destroy

  validates :login, :first_name, :last_name, :phone, :employment_status, :benefits_status, presence: true

  def name
   "#{first_name} #{last_name}"
  end

end
