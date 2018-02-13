Given(/^my client has an action plan task with an achievement$/) do
  @achievement = AchievementOption.find('job_application').name
  @action_plan_task = Fabricate(:action_plan_task, client: @client, title: @achievement)
end

Then(/^my client should have an achievement recorded$/) do
  expect(@client.achievements.count).to eq(1)
  expect(@client.achievements.first.name).to eq(AchievementOption.named(@achievement).id)
  visit advisor_client_achievements_path(@client)
  I18n.t("advisors.achievement.#{@achievement}.title.first")
end

Then(/^I should see there are no achievements yet$/) do
  expect(page).not_to have_css('.achievment')
end

When(/^I add several achievements manually$/) do
  @options = AchievementOption.all.sample(2)
  click_on @options.first.name
  (@achievements_count = 5).times do
    click_on @options.second.name
  end
end

Then(/^I should see the counts are displayed correctly$/) do
  expect(page).to have_css('.achievement', text: I18n.t("advisors.achievement.#{@options.first.id}.title.first"))
  expect(page).to have_css('.achievement', text: I18n.t("advisors.achievement.#{@options.second.id}.title.subsequent"))
  expect(page).to have_css('.achievement', text: I18n.t("advisors.achievement.#{@options.first.id}.description.first"))
  expect(page).to have_css('.achievement', text: strip_tags(I18n.t("advisors.achievement.#{@options.second.id}.description.subsequent", count: 5)))
end
