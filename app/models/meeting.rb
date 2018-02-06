class Meeting < ApplicationRecord
  validates :start_datetime, :client, :advisor, presence: true

  belongs_to :client, counter_cache: true
  belongs_to :advisor

  before_save :add_upcoming_meeting_to_client

  scope :two_hours_from_now, lambda {
    from = (Time.zone.now + 2.hours).beginning_of_hour
    within(from, from + 1.hour)
  }

  scope :two_days_from_now, lambda {
    from = (Time.zone.now + 2.days).beginning_of_day
    within(from, from + 1.day)
  }

  scope :within, ->(from, to) { where('start_datetime > ? AND start_datetime < ?', from, to) }

  private

  def add_upcoming_meeting_to_client
    return if client.upcoming_meetings.first&.start_datetime && start_datetime < client.upcoming_meetings.first&.start_datetime
    client.update_attribute(:next_meeting_date, start_datetime) # rubocop:disable Rails/SkipsModelValidations
  end
end
