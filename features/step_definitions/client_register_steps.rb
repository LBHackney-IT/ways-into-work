When(/^I follow the link to register for the service$/) do
  click_link I18n.t('devise.buttons.register')
end

Then(/^I should be asked to accept the eligibility criteria$/) do
  expect(page).to have_css("input#resident")
  expect(page).to have_css("input#unemployed")
  expect(page).to have_link I18n.t('devise.buttons.accept_terms')
end
