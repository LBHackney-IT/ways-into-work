When(/^I follow the link to register for the service$/) do
  click_link I18n.t('devise.buttons.register')
end

Then(/^I should be asked to accept the eligibility criteria$/) do
  expect(page).to have_css("input#resident")
  expect(page).to have_css("input#unemployed")
  expect(page).to have_css("#register_link.disabled a", text: I18n.t('devise.buttons.accept_terms'))
end

When(/^I register my self as "([^"]*)"$/) do |email|
  visit new_user_login_registration_path
  fill_in('Email', :with => email)
  fill_in 'user_login_password', :with => "SomeLongPassword"
  fill_in('Password confirmation', :with => "SomeLongPassword")
  click_button I18n.t('devise.buttons.sign_up')
end


Then(/^I should be asked to start creating my profile$/) do
  expect(page).to have_css("input#client_first_name")
end

When(/^I register my client details$/) do
  visit '/'
  fill_in 'client_first_name', with: FFaker::Name.first_name
  fill_in 'client_last_name', with: FFaker::Name.last_name
  fill_in 'client_phone', with: FFaker::PhoneNumber.phone_number
  select "Not currently in work", from: 'client_employment_status'
  select "Employment support allowance", from: 'client_benefits_status'
  click_button 'Create Client'
end

Then(/^my client details should be saved against my user login$/) do
  expect(Client.count).to eq(1)
  expect(Client.last.login).to eq(@user_login)
end
