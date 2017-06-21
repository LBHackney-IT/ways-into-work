Given(/^I am an advisor$/) do
  @i = Fabricate(:advisor)
end

Given(/^there is an advisor$/) do
  @advisor = Fabricate(:advisor)
end

Then(/^I should not see the client in my case load$/) do
  within '.my_clients' do
    expect(page).to have_content(I18n.t('advisors.headers.no_clients'))
    expect(page).not_to have_content(@client.name)
  end
end

When(/^I navigate to the unnassigned clients$/) do
  click_link I18n.t('buttons.unassigned_clients')
end

Then(/^I should see the new client listed$/) do
  within '.client' do
    expect(page).to have_content(@client.name)
    expect(page).to have_content(I18n.t('clients.information.registered_date', created: @client.created_at.to_date.to_s(:short)))
  end
end

When(/^I assign the client to myself$/) do
  click_on I18n.t('clients.buttons.assign_to_me')
end


Then(/^the client should be part of my case load$/) do
  expect(@i.reload.clients).to include(@client)
  visit advisor_my_clients_path
  expect(page).to have_content(@client.name)
end
