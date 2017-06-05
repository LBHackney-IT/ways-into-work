Given(/^I am a service manager$/) do
  @i = Fabricate(:service_manager)
end

Given(/^there is a service manager$/) do
  @i = Fabricate(:service_manager)
end

Then(/^I should see the new client listed$/) do
  within '.clients .client' do
    expect(page).to have_content(@client.name)
    expect(page).to have_content(I18n.t('clients.information.registered_date', created: @client.created_at.to_date.to_s(:short)))
  end
end
