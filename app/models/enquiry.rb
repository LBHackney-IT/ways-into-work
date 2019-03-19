class Enquiry < ApplicationRecord
  belongs_to :client
  belongs_to :opportunity, polymorphic: true

  enum status: %i[awaiting accepted declined]

  def opportunity
    opportunity_type.constantize.find(opportunity_id)
  end
end