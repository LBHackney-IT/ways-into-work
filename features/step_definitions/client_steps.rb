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

Given(/^the client is looking to work in Retail$/) do
  type = TypeOfWorkOption.find('retail').id # cross checking
  @client.types_of_work << type
  @client.save
end

Then(/^the client should be assigned to me$/) do
  client = Client.last
  expect(client.advisor).to eq(@i)
end
