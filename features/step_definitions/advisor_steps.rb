Given(/^I am an advisor$/) do
  @i = Fabricate(:advisor)
end

When(/^I sign in$/) do
  visit new_user_login_session_path
  fill_in 'user_login_email', with: @i.login.email
  fill_in 'user_login_password', with: @i.login.password
  click_on I18n.t('devise.buttons.login')
end

Then(/^I should be signed in$/) do
  expect(page).to have_content(I18n.t('devise.sessions.signed_in'))
end
