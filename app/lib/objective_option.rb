class ObjectiveOption
  attr_reader :id, :name

  def initialize(id, name)
    @id = id
    @name = name
  end

  def self.all
    [
      new('job', I18n.t('clients.objective.job')),
      new('apprenticeship', I18n.t('clients.objective.apprenticeship')),
      new('training', I18n.t('clients.objective.training')),
      new('work_experience', I18n.t('clients.objective.work_experience'))
    ]
  end

  def self.find(id)
    all.detect{|x| x.id == id}
  end

  def self.display(ids = [])
    ids.collect{|id| find(id).name}.join(', ')
  end

end
