module VacancyApplicationHelper
  def vacancy(vacancies, vacancy_id)
    vacancies.select { |vacancy| vacancy["id"] == vacancy_id }.try(:first)
  end
end
