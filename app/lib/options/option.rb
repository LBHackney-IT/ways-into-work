class Option
  attr_reader :id, :name

  def initialize(id, name = nil)
    @id = id
    @name = name || id
  end

  def self.find(id)
    all.detect { |x| x.id == id }
  end

  def self.find_by_name(name)
    all.detect { |x| x.name == name }
  end

  def self.display(ids = [])
    ids.collect { |id| find(id).name }.join(', ')
  end

  def self.options_for_select
    all.map { |e| [e.name, e.id] }
  end

  def self.all
    []
  end
end
