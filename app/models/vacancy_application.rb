class VacancyApplication < ApplicationRecord

  scope :awaiting_review, -> { where(dismissed: false).order(created_at: :desc) }
  scope :reviewed, -> { where(dismissed: true).order(created_at: :desc) }

  def total_applications
    VacancyApplication.where(vacancy_id: self.vacancy_id).count
  end

  def self.to_csv(vacancies)
    CSV.generate(headers: true) do |csv|
      vacancy_application_attributes = self.attribute_names
      header = vacancy_application_attributes += ["vacancy_title"]
      csv << header
      all.each do |va|
        row = attribute_names.map{ |attr| va.send(attr) }
        vacancy = vacancies.select{ |vacancy| vacancy["id"] == va.vacancy_id }.first
        if vacancy.present?
          vacancy_title = vacancy["title"]["rendered"]
        else
          vacancy_title = "Vacancy not found"
        end
        row += [vacancy_title]
        csv << row
      end
    end
  end

end
