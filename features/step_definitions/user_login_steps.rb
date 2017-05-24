module UserLoginSH

  def sign_in(login)
    visit new_user_login_session_path
    fill_in 'user_login_email', with: login.email
    fill_in 'user_login_password', with: login.password
    click_on I18n.t('devise.buttons.login')
  end

end
World UserLoginSH

Given(/^I have just registered a user login$/) do
  @user_login = Fabricate(:user_login)
end

Given(/^I sign in with the user login details$/) do
  sign_in(@user_login)
end

Given(/^I have signed in$/) do
  login_as(@user_login)
end

When(/^I sign in$/) do
  sign_in(@i.login)
end

Then(/^I should be signed in$/) do
  expect(page).to have_content(I18n.t('devise.sessions.signed_in'))
end
