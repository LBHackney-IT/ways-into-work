class ContactNote < ApplicationRecord

  belongs_to :client, counter_cache: true
  belongs_to :advisor

  validates :client_id, :advisor_id, :content, presence: true

  def contact_date
    self.created_at.to_date.to_s(:short)
  end
end
