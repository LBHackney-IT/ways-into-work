module AdvisorSH
  def my_client_listed(client = @client)
    within '.my_clients' do
      expect(page).to have_content(client.name)
    end
  end
end
World AdvisorSH

When(/^I archive the client$/) do
  click_on I18n.t('clients.buttons.make_contact')
  click_on I18n.t('clients.buttons.archive_client')
end

Then(/^the client should be removed from view$/) do
  within '#your_clients' do
    expect(page).not_to have_content(@client.name)
  end
end

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
  click_on 'View details'
  click_on I18n.t('clients.buttons.assign_to_me')
end

Then(/^the client should be part of my case load$/) do
  expect(@i.reload.clients).to include(@client)
  visit advisor_my_clients_path
  expect(page).to have_content(@client.name)
end

Given(/^there is an advisor Dave$/) do
  @dave = Fabricate(:advisor, name: 'Dave Donald')
end

Given(/^there is an advisor Dave in my hub$/) do
  @dave = Fabricate(:advisor, name: 'Dave Donald', hub: @i.hub)
end

When(/^I filter by to Retail as types of work$/) do
  select TypeOfWorkOption.find('retail').name, from: 'filterrific_by_types_of_work'
end

Then(/^I should see my client in the filtered list$/) do
  my_client_listed
end

Given(/^I register a client as "([^"]*)"$/) do |email|
  visit new_advisor_client_path
  fill_in_registration_form(email)
  click_button 'Save'
end
