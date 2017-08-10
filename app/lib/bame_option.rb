class BameOption
  attr_reader :id, :name

  def initialize(id, name)
    @id = id
    @name = name
  end

  def self.all
    [
      new('asian', 'Asian or Asian British'),
      new('black', 'Black British / African / Caribbean'),
      new('mixed', 'Mixed'),
      new('white_british', 'White British'),
      new('white', 'White Other')
    ]
  end

  def self.find(id)
    all.detect{|x| x.id == id}
  end

end
