class Meeting < ApplicationRecord

  validates :start_datetime, :client, :advisor, presence: true

  belongs_to :client
  belongs_to :advisor

end
