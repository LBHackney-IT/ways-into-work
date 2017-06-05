When(/^I follow the link to register for the service$/) do
  click_link I18n.t('devise.buttons.register')
end

Then(/^I should be asked to accept the eligibility criteria$/) do
  expect(page).to have_css("input#resident")
  expect(page).to have_css("input#unemployed")
  expect(find('#register_link input[disabled="disabled"]').value).to eq(I18n.t('devise.buttons.accept_terms'))
end

When(/^I create a new password$/) do
  fill_in 'user_login_password', :with => "SomeLongPassword"
  fill_in('Password confirmation', :with => "SomeLongPassword")
  click_button 'Save details'
end

When(/^I register my self as "([^"]*)"$/) do |email|
  visit new_client_path
  fill_in('Email', :with => email)
  client = Fabricate.build(:client)
  fill_in 'client_first_name', with: client.first_name
  fill_in 'client_last_name', with: client.last_name
  fill_in 'client_phone', with: client.phone
  fill_in 'client_address_line_1', with: client.address_line_1
  fill_in 'client_postcode', with: client.postcode
  click_button 'Save details'
end


Then(/^I should be asked to start creating my profile$/) do
  expect(page).to have_css("input#client_first_name")
end

When(/^I register my client details$/) do
  visit new_client_path
  client = Fabricate.build(:client)
  fill_in 'client_first_name', with: client.first_name
  fill_in 'client_last_name', with: client.last_name
  fill_in 'client_phone', with: client.phone
  fill_in 'client_address_line_1', with: client.address_line_1
  fill_in 'client_postcode', with: client.postcode
  click_button 'Save details'
end

Then(/^my client details should be saved against my user login$/) do
  expect(Client.count).to eq(1)
  expect(Client.last.login).to eq(@user_login)
end

Given(/^there is a client who just registered$/) do
  @client = Fabricate.build(:client)
  @client.save(validate: false)
end

Given(/^I have just signed up as a client$/) do
  @i = Fabricate.build(:client)
  @i.save(validate: false)
end

Then(/^I should be asked to provide more information$/) do
  expect(page).to have_link(I18n.t('clients.buttons.complete_profile'))
end
