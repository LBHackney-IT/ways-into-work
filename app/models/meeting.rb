class Meeting < ApplicationRecord
  validates :start_datetime, :client, :advisor, presence: true

  belongs_to :client, counter_cache: true
  belongs_to :advisor

  before_save :add_upcoming_meeting_to_client

  scope :needing_reminder_sms, lambda {
    occurring_tomorrow.where(client_id: Client.contact_by_sms.pluck(:id))
  }

  scope :occurring_tomorrow, lambda {
    tomorrow = (Time.zone.now + 1.day).beginning_of_day
    within(tomorrow, tomorrow + 1.day)
  }

  scope :within, ->(from, to) { where('start_datetime > ? AND start_datetime < ?', from, to) }

  private

  def add_upcoming_meeting_to_client
    return if client.upcoming_meetings.first&.start_datetime && start_datetime < client.upcoming_meetings.first&.start_datetime
    client.update_attribute(:next_meeting_date, start_datetime) # rubocop:disable Rails/SkipsModelValidations
  end
end
