class VacancyApplication < Application

  def self.to_csv(vacancies)
    CSV.generate(headers: true) do |csv|
      vacancy_application_attributes = self.attribute_names
      header = vacancy_application_attributes += ["vacancy_title"]
      csv << header
      all.each do |va|
        row = attribute_names.map{ |attr| va.send(attr) }
        vacancy = vacancies.select{ |vacancy| vacancy["id"] == va.wordpress_object_id }.first
        if vacancy.present?
          vacancy_title = vacancy["title"] && vacancy["title"]["rendered"]
        else
          vacancy_title = "Vacancy not found"
        end
        row += [vacancy_title]
        csv << row
      end
    end
  end

end
