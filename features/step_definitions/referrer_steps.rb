module ReferrerSH
  def fill_in_referrer_form(referrer = Fabricate.build(:referrer), client = Fabricate.build(:client), email = FFaker::Internet.email)
    fill_in 'referrer_name', with: referrer.name
    if @organisation
      find("#referrer_organisation option[value='other']").click
      fill_in 'referrer_organisation_other', with: @organisation
    else
      find("#referrer_organisation option[value='#{referrer.organisation}']").click
    end
    fill_in 'referrer_phone', with: referrer.phone
    fill_in 'referrer_email', with: referrer.email
    fill_in 'referrer_reason', with: referrer.reason

    fill_in_registration_form(email, client, 'referrer_client_attributes')
  end

  def register
    click_button I18n.t('buttons.register')
  end
  def register_referral
    click_button I18n.t('buttons.referral')
  end
end
World ReferrerSH

Given(/^I fill in the referral form$/) do
  @referrer = Fabricate.build(:referrer)
  @client = Fabricate.build(:client)
  fill_in_referrer_form @referrer, @client
  register_referral
end

When(/^I refer a client with the organisation "([^"]*)"$/) do |organisation|
  @organisation = organisation
  visit new_client_referrers_path
  fill_in_referrer_form
  register_referral
end

Then(/^a new client should be created in the database$/) do
  expect(Client.count).to eq(1)
  client = Client.first
  expect(client.first_name).to eq(@client.first_name)
  expect(client.referrer.name).to eq(@referrer.name)
end

When(/^I refer a client as needing supported employment$/) do
  visit new_client_referrers_path
  fill_in_referrer_form
  check 'referrer_client_attributes_assigned_supported_employment'
  register_referral
end

Then(/^the client should be assigned to suported employment$/) do
  expect(Client.last.assigned_supported_employment).to eq(true)
end

When(/^I refer a client$/) do
  visit new_client_referrers_path
  fill_in_referrer_form
  register_referral
end

When(/^I refer a client as "([^"]*)"$/) do |email|
  visit new_client_referrers_path
  fill_in_referrer_form Fabricate.build(:referrer), Fabricate.build(:client), email
  register_referral
end

Then(/^the client should be auto assigned to homerton$/) do
  expect(Referrer.last.client.advisor).to eq(@team_leader)
end

When(/^I refer a client with a postcode outside the borough$/) do
  client = Fabricate.build(:client, postcode: 'GU1 1YF')
  visit new_client_referrers_path
  fill_in_referrer_form Fabricate.build(:referrer), client
  register_referral
end

Then(/^I should see that the client has been referred$/) do
  expect(page).to have_content('Thanks for referring this client')
end

Then(/^the referrer should have the correct referral organisation$/) do
  client = Client.last
  expect(client.referrer.organisation).to eq(@organisation)
end
