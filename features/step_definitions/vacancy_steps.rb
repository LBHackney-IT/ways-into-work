module VacancySH
  def fill_in_vacancy_form(vacancy = Fabricate.build(:vacancy))
    fill_in :vacancy_title, with: vacancy.title
    select I18n.t("vacancies.vacancy_type.#{vacancy.vacancy_type}"), from: :vacancy_vacancy_type
    fill_in :vacancy_salary, with: vacancy.salary
    fill_in :vacancy_description, with: vacancy.description
    
    click_button I18n.t('clients.buttons.save')
    vacancy
  end
end
World VacancySH

Given(/^I create a new vacancy$/) do
  visit new_advisor_vacancy_path
  @vacancy = fill_in_vacancy_form
end

Then(/^I should be redirected to the vacancy index page$/) do
  expect(current_path).to eq(advisor_vacancies_path)
end

Then(/^the vacancy should exist in the database$/) do
  expect(Vacancy.count).to eq(1)
  vacancy = Vacancy.first
  expect(vacancy.title).to eq(@vacancy.title)
  expect(vacancy.vacancy_type).to eq(@vacancy.vacancy_type)
  expect(vacancy.salary).to eq(@vacancy.salary)
  expect(vacancy.description).to eq(@vacancy.description)
end

Given(/^there is a vacancy$/) do
  @vacancy = Fabricate.create(:vacancy)
end

Given(/^I edit the vacancy's title$/) do
  visit edit_advisor_vacancy_path(@vacancy)
  @title = 'New Title'
  fill_in_vacancy_form(Fabricate.build(:vacancy, title: @title))
end

Then(/^the vacancy's title should have changed$/) do
  @vacancy.reload
  expect(@vacancy.title).to eq(@title)
end

Given(/^I delete that vacancy$/) do
  visit advisor_vacancies_path
  click_button 'Delete'
end

Then(/^the vacancy should not exist$/) do
  expect(Vacancy.count).to eq(0)
end

Given(/^there are (\d+) vacancies$/) do |num|
  @vacancies = Fabricate.times(num.to_i, :vacancy)
end
