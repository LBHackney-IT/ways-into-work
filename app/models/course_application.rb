class CourseApplication < ApplicationRecord

  scope :awaiting_review, -> { where(dismissed: false).order(created_at: :desc) }
  scope :reviewed, -> { where(dismissed: true).order(created_at: :desc) }

  def total_applications
    CourseApplication.where(intake_id: self.intake_id).count
  end

  def self.to_csv
    CSV.generate(headers: true) do |csv|
      csv << attribute_names
      all.each do |ca|
        csv << attribute_names.map{ |attr| ca.send(attr) }
      end
    end
  end

end
