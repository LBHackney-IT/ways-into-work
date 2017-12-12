module ReferrerSH
  def fill_in_referrer_form(referrer = Fabricate.build(:referrer), client = Fabricate.build(:client), email = FFaker::Internet.email)
    fill_in 'referrer_name', with: referrer.name
    fill_in 'referrer_organisation', with: referrer.organisation
    fill_in 'referrer_phone', with: referrer.phone
    fill_in 'referrer_email', with: referrer.email
    fill_in 'referrer_reason', with: referrer.reason
            
    fill_in_registration_form(email, client, 'referrer_client_attributes')
  end
  
  def save
    click_button 'Register'
  end
end
World ReferrerSH

Given(/^I fill in the referral form$/) do
  @referrer = Fabricate.build(:referrer)
  @client = Fabricate.build(:client)
  fill_in_referrer_form @referrer, @client
  save
end

Then(/^a new client should be created in the database$/) do
  expect(Client.count).to eq(1)
  client = Client.first
  expect(client.first_name).to eq(@client.first_name)
  expect(client.referrer.name).to eq(@referrer.name)
end

When(/^I refer a client$/) do
  visit new_client_referrers_path
  fill_in_referrer_form
  save
end

When(/^I refer a client as "([^"]*)"$/) do |email|
  visit new_client_referrers_path
  fill_in_referrer_form Fabricate.build(:referrer), Fabricate.build(:client), email
  save
end

Then(/^the client should be auto assigned to homerton$/) do
  expect(Referrer.last.client.advisor).to eq(@team_leader)
end
