When(/^I indicate my client is looking to work in Retail$/) do
  find("a span", text: 'Support').click
  find("input#client_types_of_work_retail").click
  click_on 'Save'
end

Then(/^my client should be updated with looking for Retail work$/) do
  expect(page).to have_css("#flash_success", text: I18n.t('clients.flashes.success.updated'))
  expect(@client.reload.types_of_work).to be_any
  expect(@client.reload.types_of_work).to include('retail')
end
