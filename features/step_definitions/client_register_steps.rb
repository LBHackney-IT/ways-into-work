module RegistrationSH
  def fill_in_registration_form(email, client = Fabricate.build(:client), prefix = 'client')
    fill_in('Email', with: email)
    fill_in "#{prefix}_first_name", with: client.first_name
    fill_in "#{prefix}_last_name", with: client.last_name
    fill_in "#{prefix}_phone", with: client.phone
    fill_in "#{prefix}_address_line_1", with: client.address_line_1
    fill_in "#{prefix}_postcode", with: client.postcode
  end

  def save
    click_button 'Save'
  end
end
World RegistrationSH

When(/^I navigate to register for the service$/) do
  click_link I18n.t('buttons.register')
end

Then(/^I should be asked to accept the eligibility criteria$/) do
  expect(page).to have_css('input#resident')
  expect(page).to have_css('input#unemployed')
  expect(find('#register_link input[disabled="disabled"]').value).to eq(I18n.t('devise.buttons.accept_terms'))
end

When(/^I create a new password$/) do
  fill_in 'user_login_password', with: 'SomeLongPassword'
  fill_in('user_login_password_confirmation', with: 'SomeLongPassword')
  click_button 'Save'
end

When(/^I try and register with a postcode outside the borough$/) do
  client = Fabricate.build(:client, postcode: 'GU1 1YF')
  fill_in_registration_form(FFaker::Internet.email, client)
  register
end

When(/^I try and register without a postcode$/) do
  client = Fabricate.build(:client, postcode: nil)
  fill_in_registration_form(FFaker::Internet.email, client)
  register
end

Then(/^I should see an error telling me I need a postcode$/) do
  expect(page).to have_content('Postcode can\'t be blank')
end

When(/^I register my self as "([^"]*)"$/) do |email|
  visit new_client_path
  fill_in_registration_form(email)
  register
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
  @options = TrainingCourseOption.all.sample(3).collect(&:id)
  @options.each { |option| find("input[value=#{option}]", visible: false).set(true) }
end

Given(/^I go back to a previous step$/) do
  click_on I18n.t('clients.steps.about_you.short')
end

Then(/^my options should be saved$/) do
  expect(@i.reload.training_courses.sort).to eq(@options.sort)
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
  expect(page).to have_content(@i.first_name)
  expect(page).to have_content(@i.last_name)
  expect(page).to have_content(strip_tags(@i.decorate.decorate_age))
  expect(page).to have_content(@i.email)
end
