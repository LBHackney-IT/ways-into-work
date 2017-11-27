# This could just as easily be an enum
class ContactMethodOption
  attr_reader :id, :name

  def initialize(id)
    @id = id
    @name = id
  end

  def self.all
    [
      new('Email'),
      new('Phone call'),
      # new('Hub visit')
    ]
  end

  def self.find(id)
    all.detect { |x| x.id == id }
  end
end
