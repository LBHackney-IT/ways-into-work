module MeetingSH

  def double_digit(unit)
    if unit.to_s.size == 1
      "0#{unit}"
    else
      unit
    end
  end
end
World MeetingSH

Given(/^I schedule a meeting for next week with notes$/) do
  click_on I18n.t('clients.buttons.arrange_meeting')
  meeting_date = Time.now + 3.days
  select meeting_date.year, from: 'meeting_start_datetime_1i'
  select Date::MONTHNAMES[meeting_date.month], from: 'meeting_start_datetime_2i'
  select meeting_date.day, from: 'meeting_start_datetime_3i'
  select double_digit(meeting_date.hour), from: 'meeting_start_datetime_4i'
  select double_digit(meeting_date.min), from: 'meeting_start_datetime_5i'
  click_on 'Save'
end


Then(/^I should see the meeting has been booked$/) do
  within '#clients_needing_appointment' do
    expect(page).not_to have_content(@client.name)
  end
  within '#clients_with_initial_appointment' do
    expect(page).to have_content(@client.name)
  end
end

