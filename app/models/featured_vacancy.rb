class FeaturedVacancy < ApplicationRecord
  belongs_to :vacancy
  
  default_scope { order(position: :asc) }
end
