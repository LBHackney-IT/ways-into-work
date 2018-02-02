class Meeting < ApplicationRecord
  validates :start_datetime, :client, :advisor, presence: true

  belongs_to :client, counter_cache: true
  belongs_to :advisor
  
  before_save :add_upcoming_meeting_to_client
  
  private
  
  def add_upcoming_meeting_to_client
    return if client.upcoming_meetings.first&.start_datetime && start_datetime < client.upcoming_meetings.first&.start_datetime
    client.update_attribute(:next_meeting_date, start_datetime) # rubocop:disable Rails/SkipsModelValidations
  end
end
