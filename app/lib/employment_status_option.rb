class EmploymentStatusOption
  attr_reader :id, :name

  def initialize(id, name)
    @id = id
    @name = name
  end

  def self.all
    [
      new(:no_work, I18n.t('clients.employment_status.no_work')),
      new(:lt_16_hours, I18n.t('clients.employment_status.lt_16_hours')),
      new(:gte_16_hours, I18n.t('clients.employment_status.gte_16_hours')),
      new(:full_time_education, I18n.t('clients.employment_status.full_time_education')),
      new(:part_time_education, I18n.t('clients.employment_status.part_time_education')),
    ]
  end

  def self.find(id)
    all.detect{|x| x.id == id}
  end

end
