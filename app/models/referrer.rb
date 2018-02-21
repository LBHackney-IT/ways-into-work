class Referrer < ApplicationRecord
  has_one :client
  accepts_nested_attributes_for :client
  
  validates :name, :email, :reason, presence: true
  
  def send_confirmation_email
    ReferrerMailer.confirmation_email(self).deliver_now
  end
end
