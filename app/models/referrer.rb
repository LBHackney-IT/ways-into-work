class Referrer < ApplicationRecord
  has_one :client
  accepts_nested_attributes_for :client
  
  validates :name, :email, :reason, presence: true
end
