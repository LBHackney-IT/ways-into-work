module AssesmentSH
  def select_tab(name)
    # Only needed when js is enabled
    find('a span', text: name).click
    expect(find("li.ui-tab[aria-selected='true']").text).to eq(name)
  end
end
World AssesmentSH

Given(/^I indicate the client is employed for (\d+) hours a week$/) do |num|
  select_tab 'Experience'
  find("label[for='client_employed_true']").click
  fill_in 'client_working_hours_per_week', with: num
end

Then(/^the number of hours a week should be saved as (\d+)$/) do |num|
  expect(@client.reload.working_hours_per_week).to eq(num.to_i)
end

When(/^I indicate my client is looking to work in Retail$/) do
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
