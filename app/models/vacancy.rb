class Vacancy < ApplicationRecord
  enum vacancy_type: %i[full_time part_time]
  
  validates :title, :vacancy_type, :salary, :description, presence: true
end
