Given(/^I am an advisor$/) do
  @i = Fabricate(:advisor)
end

Then(/^I should not see the client in my case load$/) do
  within '.my_cases' do
    expect(page).to have_content(I18n.t('advisors.headers.no_clients'))
    expect(page).not_to have_content(@client.name)
  end
end

When(/^I navigate to the unnassigned cases$/) do
  click_link I18n.t('buttons.unassigned_cases')
end
