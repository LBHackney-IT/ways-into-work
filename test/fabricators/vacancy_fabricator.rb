Fabricator(:vacancy) do
  title { FFaker::Job.title }
  vacancy_type { Vacancy.vacancy_types.keys.sample(1).first }
  salary { FFaker::Lorem.sentence }
  description { FFaker::Lorem.sentence }
end
