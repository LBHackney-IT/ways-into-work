include ActionView::Helpers::TextHelper

Fabricator(:vacancy) do
  title { truncate(FFaker::Job.title, length: 45, separator: ' ') }
  vacancy_type { Vacancy.vacancy_types.keys.sample(1).first }
  salary { truncate(FFaker::Lorem.sentence, length: 18, separator: ' ') }
  description { truncate(FFaker::Lorem.sentence, length: 230, separator: ' ') }
end
