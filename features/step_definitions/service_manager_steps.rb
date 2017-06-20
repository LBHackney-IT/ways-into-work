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

When(/^I navigate to see the client's details$/) do
  click_on @client.name
end

Then(/^I should see that the client has not been assiged yet$/) do
  within '#actions' do
    expect(find('select#client_advisor_id').selected?).to eq(false)
    expect(find('select#client_advisor_id').value).to be_blank
  end
end

Then(/^I should be able to assign the client to the advisor$/) do
  within '#actions' do
    expect(page).to have_button(I18n.t('clients.buttons.assign_advisor'))
  end
end
