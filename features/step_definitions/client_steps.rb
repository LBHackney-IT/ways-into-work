Given(/^there is a client who has been assessed$/) do
  @client = Fabricate(:assessed_client)
end

Given(/^there is a client who just registered$/) do
  @client = Fabricate(:client)
end

Given(/^there is a client who has been archived$/) do
  @client = Fabricate(:client, deleted_at: Time.zone.now)
end

Given(/^I have just signed up as a client$/) do
  @i = Fabricate(:client)
end

Given(/^the client is assigned to me$/) do
  @i.clients << @client
end

Given(/^the client is not assigned to me$/) do
  expect(@client.advisor).to_not eq(@i)
end

Then(/^the client should not be assigned to me$/) do
  expect(@client.reload.advisor).to_not eq(@i)
end

Given(/^the client is looking to work in Retail$/) do
  type = TypeOfWorkOption.find('retail').id # cross checking
  @client.types_of_work << type
  @client.save
end

Then(/^the client should be assigned to me$/) do
  expect(Client.last.advisor).to eq(@i)
end

Then(/^that client should have an initial meeting created$/) do
  client = Client.last
  expect(client.meetings.count).to eq(1)
  meeting = client.meetings.first
  expect(meeting.agenda).to eq('initial_assessment')
end

Given(/^I have been referred$/) do
  @referrer = Fabricate.create(:referrer)
  @i.referrer = @referrer
  @i.save
end

Given(/^the client has a referrer$/) do
  @referrer = Fabricate.create(:referrer)
  @client.referrer = @referrer
  @client.save
end

Then(/^I should not see my referrer's details$/) do
  expect(page).to_not have_content(@referrer.name)
end

Given(/^I update the client's details$/) do
  click_on 'Save profile'
end

Given(/^there are (\d+) clients from my hub$/) do |i|
  @hub_clients = Fabricate.times(i.to_i, :client, hub: @i.hub)
end

Given(/^there are (\d+) clients from another hub$/) do |i|
  hub = Fabricate(:hub, name: 'Other Hub')
  @other_clients = Fabricate.times(i.to_i, :client, hub: hub)
end

Given(/^I update the client's preferred contact details to all$/) do
  ContactMethodOption.all.each do |option|
    check "client_preferred_contact_methods_#{option.id}"
  end
  click_on 'Save profile'
end

Then(/^the client should be contactable by sms reminder$/) do
  expect(@client.reload.preferred_contact_methods.sort).to eq(ContactMethodOption.all.map(&:id).sort)
end

Then(/^I should be redirected to the client's edit page$/) do
  expect(current_path).to eq(edit_advisor_client_path(@client))
end

Given(/^the client has types of work set$/) do
  @client.types_of_work = %w[catering voluntary manual_trades teaching]
  @client.save
end

Given(/^I clear the client's type of work options$/) do
  click_on 'Goals'
  @client.types_of_work.each do |type|
    find('label', text: TypeOfWorkOption.find(type).name).click
  end
  click_on 'Save profile'
end

Then(/^the client should have no types of work set$/) do
  @client.reload
  expect(@client.types_of_work).to eq([])
end

Then(/^the client's personal details should be anonymised$/) do
  @client.reload
  
  expect(@client.first_name).to eq(nil)
  expect(@client.last_name).to eq(nil)
  expect(@client.phone).to eq(nil)
  expect(@client.address_line_1).to eq(nil)
  expect(@client.address_line_2).to eq(nil)
  expect(@client.postcode).to eq(nil)
  expect(@client.date_of_birth).to eq(nil)
  expect(@client.national_insurance_number).to eq(nil)
end
