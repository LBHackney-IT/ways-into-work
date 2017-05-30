class PersonalTraitOption
  attr_reader :id, :name

  def initialize(id, name)
    @id = id
    @name = name
  end

  def self.all
    [
      new('creative', I18n.t('clients.personal_trait.creative')),
      new('active', I18n.t('clients.personal_trait.active')),
      new('caring', I18n.t('clients.personal_trait.caring')),
      new('problem_solver', I18n.t('clients.personal_trait.problem_solver')),
      new('organised', I18n.t('clients.personal_trait.organised')),
      new('people_person', I18n.t('clients.personal_trait.people_person')),
      new('persuasive', I18n.t('clients.personal_trait.persuasive')),
      new('chatty', I18n.t('clients.personal_trait.chatty'))
    ]
  end

  def self.find(id)
    all.detect{|x| x.id == id}
  end

end
