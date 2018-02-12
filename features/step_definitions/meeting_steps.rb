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
  click_on I18n.t('clients.buttons.make_contact')
  click_on I18n.t('clients.buttons.arrange_meeting')
  meeting_date = (Time.zone.now + 3.days).change(hour: rand(8..18))
  select meeting_date.year, from: 'meeting_start_datetime_1i'
  select Date::MONTHNAMES[meeting_date.month], from: 'meeting_start_datetime_2i'
  select meeting_date.day, from: 'meeting_start_datetime_3i'
  select double_digit(meeting_date.hour), from: 'meeting_start_datetime_4i'
  select '00', from: 'meeting_start_datetime_5i'
  click_on 'Save'
end

Then(/^I should see the meeting has been booked$/) do
  expect(page).not_to have_css('#clients_needing_appointment')
  within '.clickable_row.meeting' do
    expect(page).to have_content(@i.name)
    expect(page).to have_content(MeetingAgendaOption.find(@client.meetings.first.agenda).name)
  end
end

Given(/^I record I tried calling but no asnswer$/) do
  click_on I18n.t('clients.buttons.make_contact')
  choose 'contact_note_contact_method_phone_call'
  fill_in 'contact_note_content', with: 'tried calling and left a message'
  click_on 'Save'
end

Then(/^I should see the client has had contact made$/) do
  within "table tr#client_#{@client.id}" do
    expect(page).to have_content('1 time')
  end
end
