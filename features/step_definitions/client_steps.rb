Given(/^there is a client who has been assessed$/) do
  @client = Fabricate.create(:assessed_client)
end

Given(/^there is a client who just registered$/) do
  @client = Fabricate.create(:client)
end

Given(/^I have just signed up as a client$/) do
  @i = Fabricate.create(:client)
end

Given(/^the client is assigned to me$/) do
  @i.clients << @client
end

Given(/^the client is not assigned to me$/) do
  expect(@client.advisor).to_not eq(@i)
end

Then(/^the client should not be assigned to me$/) do
  client = Client.last
  expect(client.advisor).to_not eq(@i)
end

Given(/^the client is looking to work in Retail$/) do
  type = TypeOfWorkOption.find('retail').id # cross checking
  @client.types_of_work << type
  @client.save
end

Then(/^the client should be assigned to me$/) do
  client = Client.last
  expect(client.advisor).to eq(@i)
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
