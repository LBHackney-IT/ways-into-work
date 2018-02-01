When(/^I indicate my client is looking to work in Retail$/) do
  find('a span', text: 'Support').click
  find('input#client_types_of_work_retail').click
  click_on 'Save'
end

Then(/^my client should be updated with looking for Retail work$/) do
  expect(page).to have_css('#flash_success', text: I18n.t('clients.flashes.success.updated'))
  expect(@client.reload.types_of_work).to be_any
  expect(@client.reload.types_of_work).to include('retail')
end

When(/^I that my client would prefer not to give equality details$/) do
  find('#client_gender_prefer_not_to_say').click
  find('#client_bame_private').click
  find('#client_health_condition_prefer_not_to_say').click
  find('#client_care_leaver_prefer_not_to_say').click
  click_on 'Save'
end

Then(/^my client should be updated with prefer not to say for all$/) do
  expect(find("input[name='client[gender]'][checked='checked']").value).to eq('Prefer not to say')
  expect(find("input[name='client[bame]'][checked='checked']").value).to eq('private')
  expect(find("input[name='client[health_condition]'][checked='checked']").value).to eq('Prefer not to say')
  expect(find("input[name='client[care_leaver]'][checked='checked']").value).to eq('Prefer not to say')
end
