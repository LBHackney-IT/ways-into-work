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
