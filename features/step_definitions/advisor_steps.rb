module AdvisorSH
  def my_client_listed(client = @client)
    within '.my_clients' do
      expect(page).to have_content(client.name)
    end
  end

  def client_listed(client = @client)
    within '#all_clients' do
      expect(page).to have_css('.client', text: client.name)
    end
  end
end
World AdvisorSH

When(/^I archive the client$/) do
  click_on I18n.t('clients.buttons.make_contact')
  click_on I18n.t('clients.buttons.archive_client')
end

When(/^I restore the client to the system$/) do
  click_on I18n.t('clients.buttons.restore_client')
end

When(/^I anonymise the client$/) do
  click_on I18n.t('clients.buttons.anonymise_client')
end

Then(/^I should not be able to see the anonymise client button$/) do
  expect(page).not_to have_content(I18n.t('clients.buttons.anonymise_client'))
end

Then(/^I should not see the client listed$/) do
  expect(page).not_to have_content(@client.name)
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
  @team_leader = Fabricate(:advisor, role: :team_leader, hub: @hub)
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
  client_listed
end

When(/^I assign the client to myself$/) do
  click_on 'View details'
  click_on I18n.t('clients.buttons.assign_to_me')
end

Then(/^I should not be able to see the assign to me button$/) do
  click_on 'View details'
  expect(page).to_not have_content(I18n.t('clients.buttons.assign_to_me'))
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

When(/^I include archived clients in the results$/) do
  select 'All', from: 'filterrific_archived'
end

Then(/^I should see the archived client listed$/) do
  client_listed
end

Then(/^the client should be restored and found by default$/) do
  expect(@client.reload.deleted?).to eq(false)
  visit advisor_clients_path
  client_listed
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
  save
end

Given(/^I try and register a client from Haringey$/) do
  visit new_advisor_client_path
  client = Fabricate.build(:client, postcode: 'N15 5EN')
  fill_in_registration_form(FFaker::Internet.email, client)
  save
end

Then(/^I should see that the client must have a hackney postcode$/) do
  # expect(page).to have_css('#flash_error', text: I18n.t('clients.flashes.error.outside_borough'))
  expect(current_path).to eq(advisor_clients_path)
  expect(page).to have_content(I18n.t('clients.validation.outside_borough'))
end

Then(/^I should see the referrer's details$/) do
  expect(page).to have_content(@referrer.name)
end

Then(/^my hub should be selected by default$/) do
  expect(page).to have_select('filterrific_by_hub_id', selected: @i.hub.name)
end

Then(/^the any hub option should be selected by default$/) do
  expect(page).to have_select('filterrific_by_hub_id', selected: nil)
end

Then(/^I should only see clients from my hub$/) do
  @hub_clients.each do |client|
    expect(page.body).to match(ERB::Util.html_escape(client.name))
  end

  @other_clients.each do |client|
    expect(page.body).to_not match(ERB::Util.html_escape(client.name))
  end
end

Given(/^I am an admin$/) do
  @i.role = :admin
  @i.save
end

Given(/^I am an in the employer engagement team$/) do
  @i.role = :employer_engagement
  @i.save
end

Given(/^I am in the employer engagement team$/) do
  @i.role = :employer_engagement
  @i.save
end

Then(/^I should see all clients$/) do
  (@hub_clients + @other_clients).each do |client|
    expect(page.body).to match(ERB::Util.html_escape(client.name))
  end
end
