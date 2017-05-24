class TitleOption
  attr_reader :id, :name

  def initialize(id)
    @id = id
    @name = id
  end

  def self.all
    [
      new('Miss'),
      new('Mr'),
      new('Mrs'),
      new('Doctor'),
      new('Other'),
    ]
  end

  def self.find(id)
    all.detect{|x| x.id == id}
  end

end
