# rubocop:disable Style/StringLiterals
Given(/^there are (\d+) featured vacancies$/) do |num|
  @featured_vacancies = Fabricate.times(num.to_i, :featured_vacancy)
end

When(/^I drag three of the vacancies to featured slots$/) do
  @positioned_vacancies = [
    @vacancies.to_a[0],
    @vacancies.to_a[3],
    @vacancies.to_a[2]
  ]
    
  @positioned_vacancies.each_with_index do |v, i|
    target = @featured_vacancies[i]
    script = """
      source = $('#vacancy_#{v.id}');
      destination = $('#featured_vacancy_#{target.id}');
      placeVacancy(source, destination)
    """
    page.execute_script(script)
  end
end

Then(/^the featured vacancies should be stored correctly$/) do
  @featured_vacancies.each_with_index do |v, i|
    v.reload
    expect(v.vacancy).to eq(@positioned_vacancies[i])
  end
end
