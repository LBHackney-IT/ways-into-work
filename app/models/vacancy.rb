class Vacancy < ApplicationRecord
  enum vacancy_type: %i[full_time part_time]
  has_one :featured_vacancy, dependent: :nullify
  
  validates :title, :vacancy_type, :salary, :description, presence: true
end
