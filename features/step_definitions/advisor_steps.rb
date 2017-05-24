Given(/^I am an advisor$/) do
  @i = Fabricate(:advisor)
end

When(/^I sign in$/) do
  sign_in(@i.login)
end

Then(/^I should be signed in$/) do
  expect(page).to have_content(I18n.t('devise.sessions.signed_in'))
end
