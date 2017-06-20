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

When(/^I navigate to the unnassigned cases$/) do
  click_link I18n.t('buttons.unassigned_cases')
end
