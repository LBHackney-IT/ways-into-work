class AspirationOption
  attr_reader :id, :name

  def initialize(id, name)
    @id = id
    @name = name
  end

  def self.all
    [
      new('job', I18n.t('clients.aspiration.job')),
      new('apprenticeship', I18n.t('clients.aspiration.apprenticeship')),
      new('training', I18n.t('clients.aspiration.training')),
      new('work_experience', I18n.t('clients.aspiration.work_experience'))
    ]
  end

  def self.find(id)
    all.detect{|x| x.id == id}
  end

end
