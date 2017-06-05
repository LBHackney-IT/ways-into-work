class OutOfWorkOption
  attr_reader :id, :name

  def initialize(id, name)
    @id = id
    @name = name
  end

  def self.all
    [
      new('0-6', I18n.t('clients.out_of_work.0-6')),
      new('7-11', I18n.t('clients.out_of_work.7-11')),
      new('12-23', I18n.t('clients.out_of_work.12-23')),
      new('24-35', I18n.t('clients.out_of_work.24-35')),
      new('36+', I18n.t('clients.out_of_work.36+'))
    ]
  end

  def self.find(id)
    all.detect{|x| x.id == id}
  end

end
