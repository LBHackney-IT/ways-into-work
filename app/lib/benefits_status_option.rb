class BenefitsStatusOption
  attr_reader :id, :name

  def initialize(id, name)
    @id = id
    @name = name
  end

  def self.all
    [
      new(:none, I18n.t('clients.benefits_status.none')),
      new(:job_seekers, I18n.t('clients.benefits_status.job_seekers')),
      new(:employment_support, I18n.t('clients.benefits_status.employment_support')),
      new(:income_support, I18n.t('clients.benefits_status.income_support')),
      new(:universal_credit, I18n.t('clients.benefits_status.universal_credit')),
    ]
  end

  def self.find(id)
    all.detect{|x| x.id == id}
  end

end
