class VacancyApplication < ApplicationRecord

  scope :awaiting_review, -> { where(dismissed: false).order(created_at: :desc) }
  scope :reviewed, -> { where(dismissed: true).order(created_at: :desc) }

  def total_applications
    VacancyApplication.where(vacancy_id: self.vacancy_id).count
  end

end
