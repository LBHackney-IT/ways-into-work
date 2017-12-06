module RegistrationSH
  def fill_in_registration_form(email, client = Fabricate.build(:client))
    fill_in('Email', with: email)
    fill_in 'client_first_name', with: client.first_name
    fill_in 'client_last_name', with: client.last_name
    fill_in 'client_phone', with: client.phone
    fill_in 'client_address_line_1', with: client.address_line_1
    fill_in 'client_postcode', with: client.postcode
  end

  def save
    click_button 'Register'
  end
end
World RegistrationSH

When(/^I navigate to register for the service$/) do
  within '.services' do
    click_link 'Hackney Works'
  end
  click_link I18n.t('devise.buttons.register')
end

Then(/^I should be asked to accept the eligibility criteria$/) do
  expect(page).to have_css('input#resident')
  expect(page).to have_css('input#unemployed')
  expect(find('#register_link input[disabled="disabled"]').value).to eq(I18n.t('devise.buttons.accept_terms'))
end

When(/^I create a new password$/) do
  fill_in 'user_login_password', with: 'SomeLongPassword'
  fill_in('user_login_password_confirmation', with: 'SomeLongPassword')
  click_button 'Create my password'
end

When(/^I try and register with a postcode outside the borough$/) do
  client = Fabricate.build(:client, postcode: 'GU1 1YF')
  fill_in_registration_form(FFaker::Internet.email, client)
  save
end

When(/^I register my self as "([^"]*)"$/) do |email|
  visit new_client_path
  fill_in_registration_form(email)
  save
end

Given(/^when I navigate through all the profile steps$/) do
  click_on(I18n.t('clients.buttons.complete_profile'))
  (ProfileSteps::STEPS.count - 1).times do |_n|
    click_on('Next Step')
  end
  click_on('Complete Profile')
end

Given(/^I fill out the first three profile steps$/) do
  visit path_to('the client dashboard')
  click_on(I18n.t('clients.buttons.complete_profile'))
  2.times do
    click_on('Next Step')
  end
  @options = %w[nvq_level2 nvq_level3 nvq_level4]
  @options.each { |option| find("input[value=#{option}]", visible: false).set(true) }
end

Given(/^I go back to a previous step$/) do
  click_on I18n.t('clients.steps.about_you.short')
end

Then(/^my options should be saved$/) do
  @i.reload
  expect(@i.qualifications).to eq(@options)
end

Then(/^I should be asked to start creating my profile$/) do
  expect(page).to have_css('input#client_first_name')
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

Then(/^I should be asked to provide more information$/) do
  expect(page).to have_link(I18n.t('clients.buttons.complete_profile'))
end

Then(/^I should see my profile details$/) do
  expect(page).to have_content(@i.name)
  expect(page).to have_content(@i.age_in_years)
  expect(page).to have_content(@i.email)
end
