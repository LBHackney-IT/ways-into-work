Given(/^I am an advisor$/) do
  @i = Fabricate(:advisor)
end

Given(/^there is an advisor$/) do
  @advisor = Fabricate(:advisor)
end

Given(/^there is a team leader for homerton$/) do
  @team_leader = Fabricate(:advisor, team_leader: true, hub: @hub)
end

Then(/^I should be auto assigned to homerton$/) do
  expect(Client.last.advisor).to eq(@team_leader)
end


Then(/^I should not see the client in my case load$/) do
  within '.my_clients' do
    expect(page).to have_content(I18n.t('advisors.headers.no_clients'))
    expect(page).not_to have_content(@client.name)
  end
end

When(/^I navigate to see all clients$/) do
  click_link I18n.t('buttons.all_clients')
end

Then(/^I should see the new client listed$/) do
  within '.client' do
    expect(page).to have_content(@client.name)
    # expect(page).to have_content(I18n.t('clients.information.registered_date', created: @client.created_at.to_date.to_s(:short)))
  end
end

When(/^I assign the client to myself$/) do
  click_on I18n.t('clients.buttons.assign_to_me')
end

Given(/^the client is assigned to me$/) do
  @i.clients << @client
end

Then(/^the client should be part of my case load$/) do
  expect(@i.reload.clients).to include(@client)
  visit advisor_my_clients_path
  expect(page).to have_content(@client.name)
end
