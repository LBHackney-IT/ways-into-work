class Meeting < ApplicationRecord

  validates :start_datetime, :client, :advisor, presence: true

  belongs_to :client, counter_cache: :meetings_count
  belongs_to :advisor

end
